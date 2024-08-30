
// -------------
// ---- AWS ----
// -------------

module "vpc" {
  source = "./terraform-modules/aws/vpc"  # Local module

  name            = "mytube-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true
}

module "security_groups" {
  source = "./terraform-modules/aws/security-groups"  # Local module

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  allowed_cidr_blocks = ["0.0.0.0/0"]
}

module "eks" {
  source = "./terraform-modules/aws/eks"  # Local module
  cluster_name      = "my-eks-cluster"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  desired_capacity  = 2
  max_capacity      = 5
  min_capacity      = 1
  instance_types    = ["t3.small"]
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}


// ---------------
// ---- Azure ----
// ---------------

module "vnet" {
  source                   = "./terraform-module/azure/vnet"
  resource_group_name      = "myResourceGroup"
  location                 = "East EU"

  vnet_name                = "myVNet"
  vnet_address_space       = ["10.0.0.0/16"]
  
  public_subnet_name       = "myPublicSubnet"
  public_subnet_address_prefix = "10.0.1.0/24"
  
  private_subnet_name      = "myPrivateSubnet"
  private_subnet_address_prefix = "10.0.2.0/24"
  
  public_nsg_name          = "myPublicNSG"
  private_nsg_name         = "myPrivateNSG"
}


output "vnet_id" {
  value = module.azure_network.vnet_id
}

output "public_subnet_ids" {
  value = module.azure_network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.azure_network.private_subnet_ids
}
