# Déploiement MongoDB
resource "kubernetes_deployment" "mongodb" {
  metadata {
    name      = "mongodb"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          name  = "mongodb"
          image = "mongo:latest"

          port {
            container_port = 27017
          }

          env {
            name  = "MONGO_INITDB_ROOT_USERNAME"
            value = var.mongodb_root_username
          }

          env {
            name  = "MONGO_INITDB_ROOT_PASSWORD"
            value = var.mongodb_root_password
          }

          volume_mount {
            name       = "mongodb-data"
            mount_path = "/data/db"
          }
        }

        volume {
          name = "mongodb-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mongodb_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

# Déploiement Mongo Express
resource "kubernetes_deployment" "mongo_express" {
  metadata {
    name      = "mongo-express"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongo-express"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo-express"
        }
      }

      spec {
        container {
          name  = "mongo-express"
          image = "mongo-express:latest"

          port {
            container_port = 8081
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINUSERNAME"
            value = var.mongodb_root_username
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINPASSWORD"
            value = var.mongodb_root_password
          }

          env {
            name  = "ME_CONFIG_MONGODB_SERVER"
            value = "mongodb"
          }
        }
      }
    }
  }
}

# Déploiement de l'API
resource "kubernetes_deployment" "planning_gyms_api" {
  metadata {
    name      = "planning-gyms-api"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "planning-gyms-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "planning-gyms-api"
        }
      }

      spec {
        container {
          name  = "api"
          image = "${var.docker_registry}/${var.api_image}:${var.api_version}"

          port {
            container_port = 3000
          }

          env {
            name  = "MONGODB_URI"
            value = "mongodb://${var.mongodb_root_username}:${var.mongodb_root_password}@mongodb:27017/planning-gyms?authSource=admin"
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 30
            period_seconds       = 10
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 5
            period_seconds       = 10
          }
        }
      }
    }
  }
} 