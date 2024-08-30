# // ---------------
# // ---- Azure ----
# // ---------------

# module "azure_vnet" {
#   source              = "./terraform-modules/azure/vnet"
#   resource_group_name = "myResourceGroup"
#   location            = "East EU"

#   vnet_name          = "myVNet"
#   vnet_address_space = ["10.0.0.0/16"]

#   public_subnet_names    = ["myPublicSubnet"]
#   public_subnet_prefixes = ["10.0.1.0/24"]

#   private_subnet_names    = ["myPrivateSubnet"]
#   private_subnet_prefixes = ["10.0.2.0/24"]

# }

# output "vnet_id" {
#   value = module.azure_vnet.vnet_id
# }

# output "public_subnet_ids" {
#   value = module.azure_vnet.public_subnet_ids
# }

# output "private_subnet_ids" {
#   value = module.azure_vnet.private_subnet_ids
# }

# module "azure_security_groups" {
#   source              = "./terraform-modules/azure/security-groups"
#   resource_group_name = "myResourceGroup"
#   location            = "East EU"

#   private_nsg_name = "private_nsg"
#   public_nsg_name  = "public_nsg"

#   public_subnet_ids  = module.azure_vnet.public_subnet_ids
#   private_subnet_ids = module.azure_vnet.private_subnet_ids
# }

# module "aks_cluster" {
#   source   = "./terraform-modules/azure/aks"
#   location = "East EU"

#   resource_group_id   = module.azure_vnet.resource_group_id
#   resource_group_name = module.azure_vnet.resource_group_name

#   vnet_name   = module.azure_vnet.vnet_name
#   subnet_name = module.azure_vnet.private_subnet_names
#   subnet_id   = module.azure_vnet.private_subnet_ids

#   aks_cluster_name = "mytubeCluster"
#   node_count       = 3
#   node_vm_size     = "Standard_DS2_v2"
# }
