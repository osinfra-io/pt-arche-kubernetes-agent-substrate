# Input Variables
# https://opentofu.org/docs/language/values/variables

variable "chart_repository" {
  description = "OCI repository containing the Agent Substrate Helm charts"
  type        = string
  default     = "oci://ghcr.io/kagent-dev/substrate/helm"
}

variable "crds_postrender" {
  description = "Optional Helm post-renderer for the CRD chart; local fixtures use it to retain cluster-wide CRDs on uninstall"
  type = object({
    args        = optional(list(string), [])
    binary_path = string
  })
  default = null
}

variable "namespace" {
  description = "Kubernetes namespace for Agent Substrate"
  type        = string
}

variable "postgres_owner_secret_name" {
  description = "Existing Secret whose ownerConnectionString key holds the PostgreSQL owner connection string; the owner creates the schema and runs migrations"
  type        = string
  default     = "substrate-postgres-owner"
}

variable "postgres_read_write_secret_name" {
  description = "Existing Secret whose readWriteConnectionString key holds the PostgreSQL read/write connection string used for runtime queries"
  type        = string
  default     = "substrate-postgres-readwrite"
}

variable "substrate_version" {
  description = "Agent Substrate Helm chart version"
  type        = string
  default     = "1.0.1"
}
