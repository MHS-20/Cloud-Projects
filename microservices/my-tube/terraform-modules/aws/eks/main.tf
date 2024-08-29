provider "aws" {
  region = "eu-west-2"
}

// -----------------
// IAM ROLE for EKS
// -----------------
resource "aws_iam_role" "eks_node_role" {
  name = "eks-cluster-eks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_node_role.name
}

// ------------
// Creating EKS
// ------------
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_node_role.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
    endpoint_public_access = true
    endpoint_private_access = true
  }

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = var.instance_types

  tags = {
    Name = "${var.cluster_name}-node-group"
  }
}
