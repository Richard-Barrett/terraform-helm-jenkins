terraform {
  required_version = ">= 1.0.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "random" {}

resource "random_password" "jenkins_password" {
  length           = 16
  special          = true
}

module "jenkins_dev" {
  source = "../../modules/terraform-jenkins" # Adjust the path as needed

  name             = "jenkins-dev"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = "3.10.1"
  namespace        = "jenkins-dev"
  create_namespace = true

  # Inject sensitive data using templatefile
  values = concat(
    [
      templatefile("${path.module}/values/values-jenkins-dev.tpl.yaml", {
        admin_user     = "admin"
        admin_password = random_password.jenkins_password.result
      })
    ],
    var.values
  )

  timeout = 600
  atomic  = true
  wait    = true
}