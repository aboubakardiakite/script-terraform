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
  manifest = yamldecode(file("${path.module}/k8s/react-deployment.yaml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "react_service" {
  manifest = yamldecode(file("${path.module}/k8s/react-service.yaml"))
  lifecycle {
    ignore_changes = all
  }
}

# NestJS Backend API
resource "kubernetes_manifest" "workout-planner" {
  manifest = yamldecode(file("${path.module}/k8s/workout-planner.yaml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "workout-planner_service" {
  manifest = yamldecode(file("${path.module}/k8s/workout-planner-service.yaml"))
  lifecycle {
    ignore_changes = all
  }
}

# MongoDB
resource "kubernetes_manifest" "mongodb_deployment" {
  manifest = yamldecode(file("${path.module}/k8s/mongodb-deployment.yaml"))
  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_manifest" "mongodb_service" {
  manifest = yamldecode(file("${path.module}/k8s/mongodb-service.yaml"))
  lifecycle {
    ignore_changes = all
  }
}
