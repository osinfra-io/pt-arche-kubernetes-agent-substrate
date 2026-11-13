# Test
# https://opentofu.org/docs/cli/commands/test

mock_provider "helm" {}

run "default_regional" {
  command = apply

  module {
    source = "./tests/fixtures/default/regional"
  }

  assert {
    condition     = output.namespace == "ate-system"
    error_message = "The module must expose the fixture's explicitly supplied namespace."
  }

  assert {
    condition     = output.api_endpoint == "dns:///api.ate-system.svc:443"
    error_message = "The API endpoint must be derived from the namespace for kagent."
  }
}

run "postgres_secrets" {
  command = plan

  module {
    source = "./regional"
  }

  variables {
    namespace = "ate-system"
  }

  assert {
    condition = (
      yamldecode(helm_release.substrate.values[0]).postgres.ownerConnectionStringSecretRef.name == "substrate-postgres-owner" &&
      yamldecode(helm_release.substrate.values[0]).postgres.readWriteConnectionStringSecretRef.name == "substrate-postgres-readwrite"
    )
    error_message = "Agent Substrate must read its PostgreSQL connection strings from the existing Secrets."
  }
}
