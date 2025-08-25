variable "db_ip_name" {
  description = "Name of the Kubernetes Service"
  type        = string
}

variable "db_ip_labels_app" {
  description = "Label for the app"
  type        = string
}

variable "db_ip_labels_environment" {
  description = "Label for the environment"
  type        = string
}

variable "db_ip_labels_service" {
  description = "Label for the service"
  type        = string
}

variable "db_ip_type" {
  description = "Type of the Kubernetes Service (e.g., ClusterIP, NodePort, LoadBalancer)"
  type        = string
}

variable "db_ip_port" {
  description = "Port for the Kubernetes Service"
  type        = number
}

variable "db_ip_target_port" {
  description = "Target port for the Kubernetes Service"
  type        = number
}
