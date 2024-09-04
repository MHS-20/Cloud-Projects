output "service_name" {
  value = kubernetes_service.storage_service.metadata[0].name
}
