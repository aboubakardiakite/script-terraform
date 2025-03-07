terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.0"
    }
  }
  
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Configuration du provider Kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "kubernetes" {
  source = "./modules/kubernetes"

  namespace             = var.namespace
  mongodb_root_username = var.mongodb_root_username
  mongodb_root_password = var.mongodb_root_password
  docker_registry      = var.docker_registry
  api_image           = var.api_image
  api_version         = var.api_version
} 