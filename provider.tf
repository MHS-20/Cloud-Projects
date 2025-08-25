terraform {
  cloud {

    organization = "Sentinel27-Org"

    workspaces {
      name = "main-clusters"
    }
  }
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

# provider "kubernetes" {
#   alias = aks
#   host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
#   client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
#   client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
#   cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
# }

# provider "kubernetes" {
#   alias = eks
#   host                   = aws_eks_cluster.eks.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.eks.token
# }