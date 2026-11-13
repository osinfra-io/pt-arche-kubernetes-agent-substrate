# Helm Release
# https://search.opentofu.org/provider/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "substrate" {
  depends_on = [
    helm_release.substrate_atelet,
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

# atelet is a separate release so it can be upgraded before the API server, as the version skew policy requires.
resource "helm_release" "substrate_atelet" {
  depends_on = [
    helm_release.substrate_crds
  ]

  chart     = local.substrate_atelet_chart
  name      = "substrate-atelet"
  namespace = var.namespace

  values = [
    local.substrate_atelet_helm_values
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
