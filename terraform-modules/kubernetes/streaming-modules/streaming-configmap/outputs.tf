output "configmap_name" {
  value = kubernetes_config_map.streaming_configmap.metadata[0].name
}
