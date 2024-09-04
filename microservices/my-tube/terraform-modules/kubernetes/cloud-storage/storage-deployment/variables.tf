variable "service_name" {
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

variable "labels_provider" {
  description = "Label for the provider"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas for the deployment"
  type        = number
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "image_repository" {
  description = "Docker image repository"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "image_pull_policy" {
  description = "Docker image pull policy"
  type        = string
}

variable "config_map_name" {
  description = "Name of the ConfigMap containing environment variables"
  type        = string
}

variable "secret_name" {
  description = "Name of the Secret containing secure environment variables"
  type        = string
}

variable "memory_limit" {
  description = "Memory limit for the container"
  type        = string
}

variable "cpu_limit" {
  description = "CPU limit for the container"
  type        = string
}

variable "service_port" {
  description = "Port for the service"
  type        = number
}
