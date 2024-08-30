output "aks_cluster_name" {
  description = "Il nome del cluster AKS."
  value       = azurerm_kubernetes_cluster.azure-cluster.name
}
