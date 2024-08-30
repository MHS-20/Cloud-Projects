variable "location" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "resource_group_id" {
  type        = string
}

variable "vnet_name" {
  type        = string
}

variable "subnet_name" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "aks_cluster_name" {
  type        = string
}

variable "node_count" {
  type        = number
  default     = 3
}

variable "node_vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
}
