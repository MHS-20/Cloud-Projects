output "deployment_name" {
  value = kubernetes_deployment.streaming_deployment.metadata[0].name
}
