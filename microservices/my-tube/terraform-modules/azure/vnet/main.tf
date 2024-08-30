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

//------ Subnets -----
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

//------ Security Groups -----
resource "azurerm_network_security_group" "public_nsg" {
  name                = var.public_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "private_nsg" {
  name                = var.private_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}
