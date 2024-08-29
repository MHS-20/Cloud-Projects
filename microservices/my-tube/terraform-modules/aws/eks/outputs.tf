output "cluster_name" {
  value       = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_arn" {
  value       = aws_eks_cluster.eks.arn
}

output "node_group_name" {
  value       = aws_eks_node_group.node_group.node_group_name
}

output "eks_node_role_name" {
  value       = aws_iam_role.eks_node_role.name
}

output "eks_node_role_arn" {
  value       = aws_iam_role.eks_node_role.arn
}