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
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "jenkins" {
  name       = var.name
  repository = var.repository
  chart      = var.chart
  namespace  = var.chart_namespace
  version    = var.chart_version

  # Merge module's secure values with user-provided values
  # Default Values will be deployed via ./values/values-jenkins.tpl.yaml from within the module
  # These values can be overridden by the user
  # These values change depending on the tag and release of this module
  values = concat(
    [
      templatefile("${path.module}/values/values-jenkins.tpl.yaml", {
        admin_user     = var.jenkins_admin_user
        admin_password = var.jenkins_admin_password
      })
    ],
    var.values
  )

  create_namespace = var.create_namespace
  timeout          = var.timeout
  atomic           = var.atomic
  wait             = var.wait

  # Optional: Set additional Helm release settings as needed
}
