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

variable "video_storage_host" {
  description = "Video storage host to be used in the ConfigMap"
  type        = string
}

variable "video_storage_port" {
  description = "Video storage port to be used in the ConfigMap"
  type        = string
}

variable "db_host" {
  description = "Database host to be used in the ConfigMap"
  type        = string
}

variable "db_name" {
  description = "Database name to be used in the ConfigMap"
  type        = string
}
