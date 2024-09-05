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

module "load_balancer_service" {
  source = "./terraform-modules/kubernetes/Lb"

  service_name     = "mytube-lb"
  service_type     = "LoadBalancer"
  selector_app     = "mytube"
  selector_service = "video-streaming"
  port             = 80
  target_port      = 4002
}

output "load_balancer_service_name" {
  value = module.load_balancer_service.service_name
}

module "storage_service" {
  source = "./terraform-modules/kubernetes/cloud-storage/storage-service"

  service_name       = "my-storage-service"
  service_type       = "ClusterIP"
  labels_app         = "my-app"
  labels_environment = "development"
  selector_app       = "my-app"
  selector_service   = "storage"
  port               = 80
  target_port        = 4002
}

output "storage_service_name" {
  value = module.storage_service.service_name
}

module "storage_deployment" {
  source = "./terraform-modules/kubernetes/cloud-storage/storage-deployment"

  service_name       = "my-storage-deployment"
  labels_app         = "my-app"
  labels_environment = "development"
  labels_service     = "storage"
  labels_provider    = "aws"
  replica_count      = 3
  container_name     = "storage-container"
  image_name         = var.image_name
  image_pull_policy  = "IfNotPresent"
  config_map_name    = "storage-configmap"
  secret_name        = "azure-storage-access-key"
  memory_limit       = "512Mi"
  cpu_limit          = "500m"
  service_port       = 4002
}

output "storage_deployment_name" {
  value = module.storage_deployment.deployment_name
}

module "storage_configmap" {
  source = "./terraform-modules/kubernetes/cloud-storage/storage-configmap"

  configmap_name       = "storage-configmap"
  service_name         = "storage"
  port                 = "8080"
  storage_account_name = "my-storage-account"
}

output "storage_configmap_name" {
  value = module.storage_configmap.configmap_name
}

module "streaming_service" {
  source = "./terraform-modules/kubernetes/streaming/streaming-service"

  service_name       = "streaming-service"
  service_type       = "ClusterIP"
  labels_app         = "mytube"
  labels_environment = "production"
  selector_app       = "mytube"
  selector_service   = "video-streaming"
  port               = 80
  target_port        = 4002
}

output "streaming_service_name" {
  value = module.streaming_service.service_name
}

module "streaming_configmap" {
  source = "./terraform-modules/kubernetes/streaming/streaming-configmap"

  configmap_name     = "streaming-configmap"
  service_name       = "streaming"
  port               = "8080"
  video_storage_host = "videostorage.local"
  video_storage_port = "4000"
  db_host            = "database.local"
  db_name            = "streamingdb"
}

output "streaming_configmap_name" {
  value = module.streaming_configmap.configmap_name
}

module "streaming_deployment" {
  source = "./terraform-modules/kubernetes/streaming/streaming-deployment"

  deployment_name         = "streaming-deployment"
  labels_app              = "mytube"
  labels_environment      = "production"
  labels_service          = "video-streaming"
  replica_count           = 3
  container_name          = "video-streaming-container"
  image_name              = "IMAGE_PLACEHOLDER"
  image_pull_policy       = "IfNotPresent"
  resources_limits_memory = "512Mi"
  resources_limits_cpu    = "500m"
  container_port          = 8080
}

output "streaming_deployment_name" {
  value = module.streaming_deployment.deployment_name
}
