provider "kubernetes" {
  config_path = "kubeconfig.yaml"
}

variable "image_name" {
  type = string
}

module "streaming_service" {
  source = "../terraform-modules/kubernetes/streaming/streaming-service"

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
