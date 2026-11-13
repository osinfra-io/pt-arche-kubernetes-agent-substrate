# Local Values
# https://opentofu.org/docs/language/values/locals

locals {
  api_endpoint = "dns:///api.${var.namespace}.svc:443"

  substrate_atelet_chart = "${var.chart_repository}/substrate-atelet"
  substrate_chart        = "${var.chart_repository}/substrate"
  substrate_crds_chart   = "${var.chart_repository}/substrate-crds"

  substrate_sensitive_values = [
    {
      name  = "rustfs.accessKey"
      value = var.rustfs_access_key
    },
    {
      name  = "rustfs.secretKey"
      value = var.rustfs_secret_key
    }
  ]

  substrate_atelet_helm_values = yamlencode({
    objectStore = {
      credentialsSecret = var.object_store_credentials_secret_name
      endpoint          = "http://rustfs.${var.namespace}.svc:9000"
      pathStyle         = true
      region            = "us-east-1"
    }
  })

  substrate_helm_values = yamlencode({
    atelet = {
      enabled = false
    }

    atenetRouter = {
      ingressAllowedSPIFFEIDs = var.ingress_allowed_spiffe_ids
    }

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
