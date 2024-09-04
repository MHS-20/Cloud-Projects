
// Variables for VPC module

variable "name" {
  description = "VPC Name"
  type        = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  description = "Avaibility zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Cidr blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Cidr blocks for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}
