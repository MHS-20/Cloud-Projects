output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_subnet_cidr" {
  value = aws_subnet.private[*].cidr_block
}

output "public_subnet_cidr" {
  value = aws_subnet.public[*].cidr_block
}
