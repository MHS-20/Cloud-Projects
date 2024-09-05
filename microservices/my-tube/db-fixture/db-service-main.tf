provider "kubernetes" {
  config_path = "~/.kube/config" # change mode 
}

variable "image_name" {
  type = string
}

module "db_service" {
  source = "./terraform-modules/kubernetes/db/db-service"

  db_ip_name               = "my-db-service"
  db_ip_labels_app         = "my-app"
  db_ip_labels_environment = "development"
  db_ip_labels_service     = "my-db"
  db_ip_type               = "ClusterIP"
  db_ip_port               = 27017
  db_ip_target_port        = 27017
}

output "db_service_name" {
  value = module.db_service.db_service_name
}

module "db_deployment" {
  source = "./terraform-modules/kubernetes/db/db-deployment"

  db_service_name       = "my-db-deployment"
  db_labels_app         = "my-app"
  db_labels_environment = "development"
  db_labels_service     = "my-db"
  db_replica_count      = 3
  db_image_name         = "IMAGE_PLACEHOLDER"
  db_image_pull_policy  = "IfNotPresent"
  db_service_port       = 27017
}

output "db_deployment_name" {
  value = module.db_deployment.db_deployment_name
}