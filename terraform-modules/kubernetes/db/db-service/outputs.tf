output "db_service_name" {
  value = kubernetes_service.db_service.metadata[0].name
}
