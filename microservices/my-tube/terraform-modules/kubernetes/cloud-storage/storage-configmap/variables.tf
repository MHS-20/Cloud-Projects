variable "configmap_name" {
  description = "Name of the Kubernetes ConfigMap"
  type        = string
}

variable "service_name" {
  description = "Service associated with the ConfigMap"
  type        = string
}

variable "port" {
  description = "Port number to be used in the ConfigMap"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name to be used in the ConfigMap"
  type        = string
}
