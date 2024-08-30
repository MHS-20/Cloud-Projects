output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_subnet_ids" {
  value = azurerm_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = azurerm_subnet.private_subnets[*].id
}

output "public_subnet_names" {
  value = azurerm_subnet.public_subnets[*].name
}

output "private_subnet_names" {
  value = azurerm_subnet.private_subnets[*].name
}
