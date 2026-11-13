# Helm Release
# https://search.opentofu.org/provider/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "substrate" {
  depends_on = [
    helm_release.substrate_crds
  ]

  chart     = local.substrate_chart
  name      = "substrate"
  namespace = var.namespace

  values = [
    local.substrate_helm_values
  ]

  version = var.substrate_version
}

resource "helm_release" "substrate_crds" {
  chart      = local.substrate_crds_chart
  name       = "substrate-crds"
  namespace  = var.namespace
  postrender = var.crds_postrender
  version    = var.substrate_version
}
