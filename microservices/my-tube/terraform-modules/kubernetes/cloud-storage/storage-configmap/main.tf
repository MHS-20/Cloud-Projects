resource "kubernetes_config_map" "storage_configmap" {
  metadata {
    name = var.configmap_name
    labels = {
      service = var.service_name
    }
  }

  data = {
    PORT                 = var.port
    STORAGE_ACCOUNT_NAME = var.storage_account_name
  }
}
