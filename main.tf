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

# React Frontend
resource "kubernetes_manifest" "react_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/react-deployment.yml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "react_service" {
  manifest = yamldecode(file("${path.module}/k8s/react-service.yml"))
  lifecycle {
    ignore_changes = all
  }
}

# NestJS Backend API
resource "kubernetes_manifest" "workout-planner" {
  manifest = yamldecode(file("${path.module}/k8s/workout-planner.yml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "workout-planner_service" {
  manifest = yamldecode(file("${path.module}/k8s/workout-planner-service.yml"))
  lifecycle {
    ignore_changes = all
  }
}

# MongoDB
resource "kubernetes_manifest" "mongodb_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/mongodb-deployment.yml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "mongodb_service" {
  manifest = yamldecode(file("${path.module}/k8s/mongodb-service.yml"))
  lifecycle {
    ignore_changes = all
  }
}
