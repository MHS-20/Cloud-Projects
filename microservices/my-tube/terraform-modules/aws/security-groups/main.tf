// Security Groups Module

resource "aws_security_group" "public_sg" {
  name        = "public-subnet-sg"
  description = "Security Group for Public Subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP input"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow HTTPS input"
    from_port   = 443
    to_port     = 443
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

// Worker Nodes Sec Group
resource "aws_security_group" "private_sg" {
  name        = "private-subnet-sg"
  description = "Security Group for private subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Control Plane"
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

    ingress {
    description = "Allow worker nodes to communicate with each other"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

   ingress {
    description = "Allow kubelets"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow SSH ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description = "Allow all input traffic"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = var.allowed_cidr_blocks # only from same private subnet
  # }

  # egress {
  #   description = "Allow all output traffic"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1" 
  #   cidr_blocks = var.allowed_cidr_blocks # only from same private subnet
  # }
}

# resource "aws_security_group_rule" "private_to_public" {
#   description              = "Allow traffic between private and public subnets"
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 0
#   protocol                 = "-1"
#   security_group_id        = aws_security_group.public_sg.id
#   source_security_group_id = aws_security_group.private_sg.id
# }
