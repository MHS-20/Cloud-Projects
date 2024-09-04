variable "service_name" {
  description = "Name of the Kubernetes Service"
  type        = string
}

variable "service_type" {
  description = "Type of the Kubernetes Service (e.g., ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "LoadBalancer"
}

variable "selector_app" {
  description = "Label selector for the app"
  type        = string
}

variable "selector_service" {
  description = "Label selector for the service"
  type        = string
}

variable "port" {
  description = "Port for the Kubernetes Service"
  type        = number
}

variable "target_port" {
  description = "Target port for the Kubernetes Service"
  type        = number
}
