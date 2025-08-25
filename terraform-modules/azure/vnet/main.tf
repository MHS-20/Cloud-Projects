resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name          = var.vnet_name
  address_space = var.vnet_address_space

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "public_subnets" {
  count = length(var.public_subnet_prefixes)
  name  = var.public_subnet_names[count.index]

  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.public_subnet_prefixes[count.index]]

  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "private_subnets" {
  count = length(var.private_subnet_prefixes)
  name  = var.private_subnet_names[count.index]

  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.private_subnet_prefixes[count.index]]

  depends_on = [azurerm_virtual_network.vnet]
}