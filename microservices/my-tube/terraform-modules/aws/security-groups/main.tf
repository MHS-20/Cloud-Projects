// Security Groups Module

resource "aws_security_group" "public_sg" {
  name        = "public-subnet-sg"
  description = "Security Group for Public Subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow Kubernetes (API)"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow HTTP output"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow HTTPS output"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private-subnet-sg"
  description = "Security Group for private subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Kubernetes (API)"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Permetti tutto il traffico interno tra nodi"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    description = "Permetti tutto il traffico in uscita"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "private_to_public" {
  description              = "Allow traffic between private and public subnets"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.public_sg.id
  source_security_group_id = aws_security_group.private_sg.id
}
