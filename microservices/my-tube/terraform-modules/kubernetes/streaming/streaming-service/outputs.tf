output "service_name" {
  value = kubernetes_service.streaming_service.metadata[0].name
}
