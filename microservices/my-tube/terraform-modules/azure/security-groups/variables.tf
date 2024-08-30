variable "public_nsg_name" {
  type        = string
}

variable "private_nsg_name" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "public_subnet_ids" {
  type        = list(string)
}

variable "private_subnet_ids" {
  type        = list(string)
}
