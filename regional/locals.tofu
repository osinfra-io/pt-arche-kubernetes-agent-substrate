# Local Values
# https://opentofu.org/docs/language/values/locals

locals {
  api_endpoint = "dns:///api.${var.namespace}.svc:443"

  substrate_chart      = "${var.chart_repository}/substrate"
  substrate_crds_chart = "${var.chart_repository}/substrate-crds"

  substrate_helm_values = yamlencode({
    postgres = {
      ownerConnectionStringSecretRef = {
        key  = "ownerConnectionString"
        name = var.postgres_owner_secret_name
      }
      readWriteConnectionStringSecretRef = {
        key  = "readWriteConnectionString"
        name = var.postgres_read_write_secret_name
      }
    }
  })
}
