output "api_endpoint" {
  description = "URL de l'API"
  value       = "http://${module.kubernetes.node_ip}:30000"
}

output "mongo_express_endpoint" {
  description = "URL de Mongo Express"
  value       = "http://${module.kubernetes.node_ip}:30081"
} 