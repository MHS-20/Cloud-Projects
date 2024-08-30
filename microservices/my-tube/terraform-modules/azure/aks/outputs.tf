output "kube_config" {
  description = "Il kubeconfig file per accedere al cluster AKS."
  value       = azurerm_kubernetes_cluster.example.kube_config.0.raw_kube_config
}

output "aks_cluster_name" {
  description = "Il nome del cluster AKS."
  value       = azurerm_kubernetes_cluster.example.name
}
