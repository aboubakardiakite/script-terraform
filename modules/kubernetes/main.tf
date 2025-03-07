resource "kubernetes_namespace" "planning_gyms" {
  metadata {
    name = var.namespace
  }
}

# Inclure les autres ressources Kubernetes ici... 