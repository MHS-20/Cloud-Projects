output "public_nsg_name" {
  value = azurerm_network_security_group.public_nsg.name
}

output "private_nsg_name" {
  value = azurerm_network_security_group.private_nsg.name
}
