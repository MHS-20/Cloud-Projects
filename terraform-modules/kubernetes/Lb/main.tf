resource "kubernetes_service" "load_balancer" {
  metadata {
    name = var.service_name
  }

  spec {
    type = var.service_type

    selector = {
      app     = var.selector_app
      service = var.selector_service
    }

    port {
      port        = var.port
      target_port = var.target_port
    }
  }
}
