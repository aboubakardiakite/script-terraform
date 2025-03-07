variable "namespace" {
  description = "Namespace Kubernetes pour le déploiement"
  type        = string
}

variable "mongodb_root_username" {
  description = "Nom d'utilisateur root MongoDB"
  type        = string
}

variable "mongodb_root_password" {
  description = "Mot de passe root MongoDB"
  type        = string
}

variable "docker_registry" {
  description = "Registry Docker pour les images"
  type        = string
}

variable "api_image" {
  description = "Nom de l'image Docker de l'API"
  type        = string
}

variable "api_version" {
  description = "Version de l'image Docker de l'API"
  type        = string
} 