output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "public_sg_name" {
  value = aws_security_group.public_sg.name
}

output "private_sg_name" {
  value = aws_security_group.private_sg.name
}
