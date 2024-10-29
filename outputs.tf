output "name" {
  description = "The name of the Helm release."
  value       = helm_release.jenkins.name
}

output "namespace" {
  description = "The namespace the Helm release is deployed into."
  value       = helm_release.jenkins.namespace
}

output "status" {
  description = "The status of the Helm release."
  value       = helm_release.jenkins.status
}

output "chart" {
  description = "The chart that was deployed."
  value       = helm_release.jenkins.chart
}

output "version" {
  description = "The version of the Helm chart that was deployed."
  value       = helm_release.jenkins.version
}
