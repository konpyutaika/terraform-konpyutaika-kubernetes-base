# Squid System Space

## squid-system namespaces provisioning
resource "kubernetes_namespace" "system" {
  metadata {
    annotations = {
      name = var.system_namespace
    }
    name = var.system_namespace
  }
}

locals {
  oidc_secrets = templatefile(
    "${path.module}/files/auth_secret.properties", {
      discovery_url      = var.authservice_issuer
      oidc_client_id     = var.authservice_client_id
      oidc_client_secret = var.authservice_client_secret
    }
  )
}

resource "kubernetes_secret" "oidc" {
  metadata {
    name      = var.oidc_secret_ref.name
    namespace = var.oidc_secret_ref.namespace
  }
  data = {
    "${var.oidc_secret_ref.data}" = local.oidc_secrets
  }
}