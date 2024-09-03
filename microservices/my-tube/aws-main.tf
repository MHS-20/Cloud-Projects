
// -------------
// ---- AWS ----
// -------------

module "aws_vpc" {
  source = "./terraform-modules/aws/vpc" # Local module

  name               = "mytube-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-west-2a", "eu-west-2b"]
  public_subnets     = ["10.0.1.0/24"] // , "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24" , "10.0.4.0/24"]
  enable_nat_gateway = true
}

module "aws_security_groups" {
  source = "./terraform-modules/aws/security-groups" # Local module

  vpc_id              = module.aws_vpc.vpc_id
  public_subnet_ids   = module.aws_vpc.public_subnet_ids
  private_subnet_ids  = module.aws_vpc.private_subnet_ids

  public_cidr_blocks = module.aws_vpc.public_subnet_cidr
  private_cidr_blocks = module.aws_vpc.private_subnet_cidr
}

module "aws_eks" {
  source             = "./terraform-modules/aws/eks" # Local module
  cluster_name       = "my-eks-cluster"
  vpc_id             = module.aws_vpc.vpc_id
  public_subnet_ids  = module.aws_vpc.public_subnet_ids
  private_subnet_ids = module.aws_vpc.private_subnet_ids

  worker_security_group_id = module.aws_security_groups.private_sg_id

  desired_capacity = 2
  max_capacity     = 5
  min_capacity     = 1
  instance_types   = ["t3.small"]
}

output "eks_cluster_name" {
  value = module.aws_eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.aws_eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.aws_eks.cluster_arn
}

output "public_sg_id" {
  value       = module.aws_security_groups.public_sg_id
}

output "private_sg_id" {
  value       = module.aws_security_groups.private_sg_id
}
