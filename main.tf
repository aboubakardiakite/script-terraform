terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

locals {
  timestamp = timestamp()  # Génère un timestamp unique à chaque apply
}

# React Frontend
resource "kubernetes_manifest" "react_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "react-app"
      namespace = "default"
      annotations = {
        "timestamp" = local.timestamp  # Force le redéploiement
      }
    }
    spec = {
      template = {
        spec = {
          containers = [
            {
              image = "your-image:latest"
              imagePullPolicy = "Always"  # Force à toujours tirer l'image
              // ... reste de la configuration ...
            }
          ]
        }
      }
    }
    // ... reste de la configuration ...
  }
}

resource "kubernetes_manifest" "react_service" {
  manifest = yamldecode(file("${path.module}/k8s/react-service.yml"))
}

# NestJS Backend API
resource "kubernetes_manifest" "workout-planner" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "workout-planner"
      namespace = "default"
      annotations = {
        "timestamp" = local.timestamp  # Force le redéploiement
      }
    }
    spec = {
      template = {
        spec = {
          containers = [
            {
              image = "your-image:latest"
              imagePullPolicy = "Always"  # Force à toujours tirer l'image
              // ... reste de la configuration ...
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "workout-planner_service" {
  manifest = yamldecode(file("${path.module}/k8s/workout-planner.service.yml"))
}

# MongoDB
resource "kubernetes_manifest" "mongodb_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "mongodb"
      namespace = "default"
      annotations = {
        "timestamp" = local.timestamp  # Force le redéploiement
      }
    }
    spec = {
      template = {
        spec = {
          containers = [
            {
              image = "your-image:latest"
              imagePullPolicy = "Always"  # Force à toujours tirer l'image
              // ... reste de la configuration ...
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "mongodb_service" {
  manifest = yamldecode(file("${path.module}/k8s/mongodb-service.yml"))
}
