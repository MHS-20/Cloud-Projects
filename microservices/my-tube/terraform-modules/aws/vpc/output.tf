// VPC module outputs

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidr" {
  description = "Private subnet cidr blocks"
  value       = aws_subnet.private[*].cidr_block
}

output "public_subnet_cidr" {
  description = "Public subnet cidr blocks"
  value       = aws_subnet.public[*].cidr_block
}