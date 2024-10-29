variable "name" {
  description = "The name of the Helm release."
  type        = string
  default     = "jenkins"
}

variable "repository" {
  description = "The Helm chart repository URL."
  type        = string
  default     = "https://charts.jenkins.io"
}

variable "chart" {
  description = "The name of the Helm chart to deploy."
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "The version of the Helm chart to deploy."
  type        = string
  default     = "3.10.1" # Update to the desired chart version
}

variable "chart_namespace" {
  description = "The Kubernetes namespace to deploy the Helm release into."
  type        = string
  default     = "jenkins"
}

variable "values" {
  description = "A list of values to be passed to the Helm chart."
  type        = list(string)
  default     = []
}

variable "create_namespace" {
  description = "Whether to create the namespace if it does not exist."
  type        = bool
  default     = true
}

variable "timeout" {
  description = "The maximum time to wait for any individual Kubernetes operation."
  type        = number
  default     = 600
}

variable "atomic" {
  description = "If set, the installation process deletes the release on failure."
  type        = bool
  default     = true
}

variable "wait" {
  description = "If set, will wait until all resources are in a ready state before marking the release as successful."
  type        = bool
  default     = true
}

variable "kubeconfig_path" {
  description = "Path to the Kubernetes configuration file."
  type        = string
  default     = "~/.kube/config"
}

# environments/dev/variables.tf
variable "jenkins_admin_user" {
  description = "The admin username for Jenkins."
  type        = string
  default     = "devadmin"
}

variable "jenkins_admin_password" {
  description = "The admin password for Jenkins."
  type        = string
  sensitive   = true
  default     = ""
}
