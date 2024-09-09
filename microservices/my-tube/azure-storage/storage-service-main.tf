terraform {
  cloud {

    organization = "Sentinel27-Org"

    workspaces {
      name = "azure-storage-state"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "aws" {
  region = "eu-west-2"
  // profile = "default"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variable "image_name" {
  type = string
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
