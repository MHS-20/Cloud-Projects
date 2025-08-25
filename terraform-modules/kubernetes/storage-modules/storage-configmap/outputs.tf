output "configmap_name" {
  value = kubernetes_config_map.storage_configmap.metadata[0].name
}
