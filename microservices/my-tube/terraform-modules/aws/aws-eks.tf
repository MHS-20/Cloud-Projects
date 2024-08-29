module "eks" {
  source          = "terraform-modules/aws/aws-eks"
  version         = "0.1.0"

  cluster_name    = "mytube-cluster"
  cluster_version = "1.26"

  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 4
      min_capacity     = 1

      instance_type = "t3.small"
    }
  }
}
