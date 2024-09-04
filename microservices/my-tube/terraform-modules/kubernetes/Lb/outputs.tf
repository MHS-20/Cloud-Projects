output "service_name" {
  value = kubernetes_service.load_balancer.metadata[0].name
}
