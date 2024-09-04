resource "kubernetes_deployment" "storage_deployment" {
  metadata {
    name = var.service_name
    labels = {
      app         = var.labels_app
      environment = var.labels_environment
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app      = var.labels_app
        service  = var.labels_service
        provider = var.labels_provider
      }
    }

    template {
      metadata {
        labels = {
          app      = var.labels_app
          service  = var.labels_service
          provider = var.labels_provider
        }
      }

      spec {
        image_pull_secrets {
          name = "docker-registry-secret"
        }

        container {
          name              = var.container_name
          image             = "${var.image_name}"
          image_pull_policy = var.image_pull_policy

          env {
            name = "PORT"
            value_from {
              config_map_key_ref {
                name = var.config_map_name
                key  = "PORT"
              }
            }
          }

          env {
            name = "STORAGE_ACCOUNT_NAME"
            value_from {
              config_map_key_ref {
                name = var.config_map_name
                key  = "STORAGE_ACCOUNT_NAME"
              }
            }
          }

          env {
            name = "STORAGE_ACCESS_KEY"
            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "STORAGE_ACCESS_KEY"
              }
            }
          }

          port {
            container_port = var.service_port
          }
        }
      }
    }
  }
}
