module "agent_substrate" {
  source = "../../../../regional"

  namespace         = "ate-system"
  rustfs_access_key = "test-access"
  rustfs_secret_key = "test-secret"
}

output "api_endpoint" {
  value = module.agent_substrate.api_endpoint
}

output "namespace" {
  value = module.agent_substrate.namespace
}
