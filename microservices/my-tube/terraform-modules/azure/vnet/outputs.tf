output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
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

output "public_nsg_name" {
  value = azurerm_network_security_group.public_nsg.name
}

output "private_nsg_name" {
  value = azurerm_network_security_group.private_nsg.name
}
