# Service MongoDB
resource "kubernetes_service" "mongodb" {
  metadata {
    name      = "mongodb"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.mongodb.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 27017
      target_port = 27017
    }

    type = "ClusterIP"
  }
}

# Service Mongo Express
resource "kubernetes_service" "mongo_express" {
  metadata {
    name      = "mongo-express"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.mongo_express.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 8081
      target_port = 8081
      node_port   = 30081
    }

    type = "NodePort"
  }
}

# Service API
resource "kubernetes_service" "planning_gyms_api" {
  metadata {
    name      = "planning-gyms-api"
    namespace = kubernetes_namespace.planning_gyms.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.planning_gyms_api.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 3000
      target_port = 3000
      node_port   = 30000
    }

    type = "NodePort"
  }
} 