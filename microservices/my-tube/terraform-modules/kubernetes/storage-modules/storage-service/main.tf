resource "kubernetes_service" "storage_service" {
  metadata {
    name = var.service_name
    labels = {
      app         = var.labels_app
      environment = var.labels_environment
    }
  }

  spec {
    type = var.service_type

    selector = {
      app     = var.selector_app
      service = var.selector_service
    }

    port {
      protocol    = "TCP"
      port        = var.port
      target_port = var.target_port
    }
  }
}
