resource "azurerm_network_security_group" "public_nsg" {
  name                = var.public_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "private_nsg" {
  name                = var.private_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_assoc" {
  count = length(var.public_subnet_ids)

  subnet_id                 = var.public_subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}


resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_assoc" {
  count = length(var.private_subnet_ids)

  subnet_id                 = var.private_subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}



// ---- Rules ---

resource "azurerm_network_security_rule" "allow_http_inbound" {
  name                        = "Allow-HTTP-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

resource "azurerm_network_security_rule" "allow_https_inbound" {
  name                        = "Allow-HTTPS-Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

resource "azurerm_network_security_rule" "allow_ssh_inbound" {
  name                        = "Allow-SSH-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.private_nsg.name
}

# resource "azurerm_network_security_rule" "allow_k8s_api_public" {
#   name                        = "Allow-k8sAPI-Inbound"
#   priority                    = 110
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "6443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.private_nsg.name
# }

# resource "azurerm_network_security_rule" "allow_k8s_api_private" {
#   name                        = "Allow-k8sAPI-Inbound"
#   priority                    = 110
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "6443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.public_nsg.name
# }

#  security_rule {
#     name                       = "Allow-Inbound-From-Private-Subnet"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = azurerm_subnet.private_subnet.address_prefix
#     destination_address_prefix = azurerm_subnet.public_subnet.address_prefix
#   }

#   security_rule {
#     name                       = "Allow-Outbound-To-Private-Subnet"
#     priority                   = 200
#     direction                  = "Outbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = azurerm_subnet.public_subnet.address_prefix
#     destination_address_prefix = azurerm_subnet.private_subnet.address_prefix
#   }

#  security_rule {
#     name                       = "Allow-Inbound-From-Private-Subnet"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = azurerm_subnet.private_subnet.address_prefix
#     destination_address_prefix = azurerm_subnet.public_subnet.address_prefix
#   }

#   security_rule {
#     name                       = "Allow-Outbound-To-Private-Subnet"
#     priority                   = 200
#     direction                  = "Outbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = azurerm_subnet.public_subnet.address_prefix
#     destination_address_prefix = azurerm_subnet.private_subnet.address_prefix
#   }
