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