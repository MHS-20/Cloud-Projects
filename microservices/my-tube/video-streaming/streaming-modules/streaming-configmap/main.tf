resource "kubernetes_config_map" "streaming_configmap" {
  metadata {
    name = var.configmap_name
    labels = {
      service = var.service_name
    }
  }

  data = {
    PORT               = var.port
    VIDEO_STORAGE_HOST = var.video_storage_host
    VIDEO_STORAGE_PORT = var.video_storage_port
    DBHOST             = var.db_host
    DBNAME             = var.db_name
  }
}
