resource "kubernetes_service" "db_service" {
  metadata {
    name = var.db_ip_name
    labels = {
      app         = var.db_ip_labels_app
      environment = var.db_ip_labels_environment
    }
  }

  spec {
    type = var.db_ip_type

    selector = {
      app     = var.db_ip_labels_app
      service = var.db_ip_labels_service
    }

    port {
      protocol    = "TCP"
      port        = var.db_ip_port
      target_port = var.db_ip_target_port
    }
  }
}
