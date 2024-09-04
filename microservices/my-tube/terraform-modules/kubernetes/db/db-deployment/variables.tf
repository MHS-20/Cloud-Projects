variable "db_service_name" {
  description = "Name of the Kubernetes Deployment"
  type        = string
}

variable "db_labels_app" {
  description = "Label for the app"
  type        = string
}

variable "db_labels_environment" {
  description = "Label for the environment"
  type        = string
}

variable "db_labels_service" {
  description = "Label for the service"
  type        = string
}

variable "db_replica_count" {
  description = "Number of replicas"
  type        = number
}

variable "db_image_repository" {
  description = "Docker image repository"
  type        = string
}

variable "db_image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "db_image_pull_policy" {
  description = "Docker image pull policy"
  type        = string
}

variable "db_service_port" {
  description = "Port for the container"
  type        = number
}
