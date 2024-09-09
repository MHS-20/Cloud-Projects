resource "kubernetes_deployment" "streaming_deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      app         = var.labels_app
      environment = var.labels_environment
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app     = var.labels_app
        service = var.labels_service
      }
    }

    template {
      metadata {
        labels = {
          app     = var.labels_app
          service = var.labels_service
        }
      }

      spec {
        image_pull_secrets {
          name = "docker-registry-secret"
        }

        container {
          name              = var.container_name
          image             = var.image_name
          image_pull_policy = var.image_pull_policy

          env {
            name = "PORT"
            value_from {
              config_map_key_ref {
                name = "streaming-configmap"
                key  = "PORT"
              }
            }
          }

          env {
            name = "VIDEO_STORAGE_HOST"
            value_from {
              config_map_key_ref {
                name = "streaming-configmap"
                key  = "VIDEO_STORAGE_HOST"
              }
            }
          }

          env {
            name = "VIDEO_STORAGE_PORT"
            value_from {
              config_map_key_ref {
                name = "streaming-configmap"
                key  = "VIDEO_STORAGE_PORT"
              }
            }
          }

          env {
            name = "DBHOST"
            value_from {
              config_map_key_ref {
                name = "streaming-configmap"
                key  = "DBHOST"
              }
            }
          }

          env {
            name = "DBNAME"
            value_from {
              config_map_key_ref {
                name = "streaming-configmap"
                key  = "DBNAME"
              }
            }
          }

          resources {
            limits = {
              memory = var.resources_limits_memory
              cpu    = var.resources_limits_cpu
            }
          }

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}
