resource "kubernetes_namespace" "istio-system" {
  metadata {
    annotations = {
      name  = var.istio-system_namespace
    }
    labels = {
      istio-injection = "disabled"
      istio-operator-managed = "Reconcile"
    }
    name = var.istio-system_namespace
  }
}

module "istio" {
#  source = "git::https://gitlab.si.francetelecom.fr/analytics/squidflow/provisioning/terraform-modules/squidflow.istio/?ref=0.0.1"
  source = "../../istio"
  istio_namespace                 = kubernetes_namespace.istio-system.metadata.0.name
  create_istio_namespace          = false
  istio_operator_namespace        = kubernetes_namespace.system.metadata.0.name
  create_istio_operator_namespace = false

  grafana_subpath = "/admin/grafana"
  kiali_path      = "/admin/kiali"
  tracing_path    = "/admin/tracing"
  prometheus_path = "/admin/prometheus"

  ingress_gateway_annotations = {
    //    "cloud.google.com/neg" = "\"{\\\"exposed_ports\\\": {\\\"80\\\":{}, \\\"443\\\":{}}}\"",
    //    "cloud.google.com/load-balancer-type" = "Internal"
  }
  // ingress_gateway_source_ranges = "192.168.0.0/16,10.0.0.0/8"
  // ingress_gateway_selector
  // ingress_gateway_ip
  // istio_version
  depends_on = [kubernetes_namespace.system, module.istio_system_external_dns]

}

module "authservice-oidc" {
#  source = "git::https://gitlab.si.francetelecom.fr/analytics/squidflow/provisioning/terraform-modules/squidflow.auth/?ref=0.0.1"
  source = "../../auth"

  authservice   = {
    client_id     = var.authservice_client_id
    client_secret = var.authservice_client_secret
    issuer        = var.authservice_issuer
    auth_url      = ""
    redirect_url  = "https://console.${var.dns_name}/login/oidc"
    userid_claim  = "email"
    scopes        = "profile email"
  }
  namespace     = kubernetes_namespace.istio-system.metadata.0.name
  userid_header = "userid"

  depends_on = [module.istio]
}
