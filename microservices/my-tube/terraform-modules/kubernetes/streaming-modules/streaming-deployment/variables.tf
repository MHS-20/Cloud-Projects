variable "deployment_name" {
  description = "Name of the Kubernetes Deployment"
  type        = string
}

variable "labels_app" {
  description = "Label for the app"
  type        = string
}

variable "labels_environment" {
  description = "Label for the environment"
  type        = string
}

variable "labels_service" {
  description = "Label for the service"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas"
  type        = number
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "image_name" {
  type = string
}

variable "image_pull_policy" {
  description = "Image pull policy"
  type        = string
}

variable "resources_limits_memory" {
  description = "Memory limit for the container"
  type        = string
}

variable "resources_limits_cpu" {
  description = "CPU limit for the container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}
