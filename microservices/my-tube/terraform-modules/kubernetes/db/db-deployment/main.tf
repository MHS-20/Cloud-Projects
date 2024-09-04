resource "kubernetes_deployment" "db_deployment" {
  metadata {
    name = var.db_service_name
    labels = {
      app         = var.db_labels_app
      environment = var.db_labels_environment
    }
  }

  spec {
    replicas = var.db_replica_count

    selector {
      match_labels = {
        app     = var.db_labels_app
        service = var.db_labels_service
      }
    }

    template {
      metadata {
        labels = {
          app     = var.db_labels_app
          service = var.db_labels_service
        }
      }

      spec {
        image_pull_secrets {
          name = "docker-registry-secret"
        }

        container {
          name              = var.db_labels_service
          image             = "${var.db_image_repository}:${var.db_image_tag}"
          image_pull_policy = var.db_image_pull_policy

          port {
            container_port = var.db_service_port
          }

          env {
            name  = "MONGO_INITDB_ROOT_USERNAME"
            value = "mytube"
          }

          env {
            name  = "MONGO_INITDB_ROOT_PASSWORD"
            value = "secretpassword"
          }

          env {
            name  = "MONGO_INITDB_DATABASE"
            value = "mydb"
          }


        }
      }
    }
  }
}
