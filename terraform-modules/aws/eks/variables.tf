variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "desired_capacity" {
  type    = number
  default = 3
}

variable "max_capacity" {
  type    = number
  default = 4
}

variable "min_capacity" {
  type    = number
  default = 2
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "worker_security_group_id" {
  type = string
}