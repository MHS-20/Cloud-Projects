variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "vnet_name" {
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR for VNet"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "public_subnet_prefixes" {
  description = "CIDR list for public subnets"
  type        = list(string)
}

variable "private_subnet_prefixes" {
  description = "CIDR list for private subnets"
  type        = list(string)
}

variable "public_subnet_names" {
  type        = list(string)
  default     = ["public-subnet-1", "public-subnet-2"]
}

variable "private_subnet_names" {
  type        = list(string)
  default     = ["private-subnet-1", "private-subnet-2"]
}

variable "public_nsg_name" {
  description = "Il nome del Network Security Group per la subnet pubblica"
  type        = string
}

variable "private_nsg_name" {
  description = "Il nome del Network Security Group per la subnet privata"
  type        = string
}