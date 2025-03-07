# Infrastructure Terraform pour Planning Gyms

Ce repository contient les fichiers Terraform pour déployer l'infrastructure de Planning Gyms sur Kubernetes.

## Prérequis

- Terraform >= 1.7.0
- Accès à un cluster Kubernetes (via ~/.kube/config)
- Runner GitHub configuré avec accès au cluster
- Accès à Docker Hub pour pull les images

## Structure

```
.
├── .github/
│   └── workflows/          # Workflows GitHub Actions
├── environments/           # Variables par environnement
│   ├── dev/
│   └── prod/
├── modules/               # Modules Terraform réutilisables
│   └── kubernetes/
├── main.tf               # Configuration principale
├── variables.tf          # Définition des variables
├── terraform.tfvars      # Valeurs des variables
├── deployments.tf        # Déploiements Kubernetes
├── services.tf           # Services Kubernetes
└── storage.tf           # Volumes persistants
```

## Déploiement

Le déploiement est automatisé via GitHub Actions et se déclenche :
1. À chaque push sur la branche main
2. Lors d'un nouveau déploiement de l'API (via webhook)

## Variables requises

- `mongodb_root_username`: Utilisateur root MongoDB
- `mongodb_root_password`: Mot de passe root MongoDB
- `docker_registry`: Registry Docker (default: "aboubakar940")
- `api_image`: Nom de l'image (default: "workout-planner")
- `api_version`: Version de l'image (mise à jour automatiquement)