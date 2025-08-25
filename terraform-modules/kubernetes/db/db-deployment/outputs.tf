output "db_deployment_name" {
  value = kubernetes_deployment.db_deployment.metadata[0].name
}
