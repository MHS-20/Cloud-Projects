provider "aws" {
  region  = "eu-west-2" 
  version = "~> 4.0"     
  profile = "default"
}

provider "azurerm" {
  features {}
  version = "~> 3.0"
}