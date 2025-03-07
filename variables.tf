variable "namespace" {
  description = "Namespace Kubernetes pour le déploiement"
  type        = string
  default     = "planning-gyms"
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
  default     = "aboubakar940"
}

variable "api_image" {
  description = "Nom de l'image Docker de l'API"
  type        = string
  default     = "workout-planner"
}

variable "api_version" {
  description = "Version de l'image Docker de l'API"
  type        = string
  default     = "latest"
} 