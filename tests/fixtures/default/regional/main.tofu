module "agent_substrate" {
  source = "../../../../regional"

  namespace = "ate-system"
}

output "api_endpoint" {
  value = module.agent_substrate.api_endpoint
}

output "namespace" {
  value = module.agent_substrate.namespace
}
