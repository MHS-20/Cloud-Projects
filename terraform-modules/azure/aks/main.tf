resource "azurerm_kubernetes_cluster" "azure-cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_cluster_name

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.node_vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_role_assignment" "aks" {
  principal_id         = azurerm_kubernetes_cluster.azure-cluster.identity[0].principal_id
  role_definition_name = "Contributor"
  scope                = var.resource_group_id
}
