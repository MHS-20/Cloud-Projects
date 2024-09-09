output "deployment_name" {
  value = kubernetes_deployment.storage_deployment.metadata[0].name
}
