# Output Values
# https://opentofu.org/docs/language/values/outputs

output "api_endpoint" {
  description = "gRPC endpoint of the Agent Substrate API server, for kagent"
  value       = local.api_endpoint
}

output "namespace" {
  description = "Namespace containing Agent Substrate"
  value       = var.namespace
}
