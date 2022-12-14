module "system_external_dns" {
  source = "git::https://github.com/konpyutaika/terraform-external-dns-k8s.git/?ref=1.0.0"
  # Kubernetes
  kubernetes_cluster_name = var.kubernetes_cluster_name
  watch_istio = true

  # External-dns
  external_dns_namespace = kubernetes_namespace.front_office.metadata.0.name
  external_dns_sa_annotations = var.external_dns_sa_annotations
  external_dns_additional_args = var.external_dns_additional_args

  # Cloud DNS
  dns_name                 = var.dns_name
  external_dns_image       = "bitnami/external-dns:0.12.0"
  kubernetes_node_selector = {}
}

module "istio_system_external_dns" {
  source = "git::https://github.com/konpyutaika/terraform-external-dns-k8s.git/?ref=1.0.0"
  # Kubernetes
  kubernetes_cluster_name = var.kubernetes_cluster_name
  watch_istio = true

  # External-dns
  external_dns_namespace = kubernetes_namespace.istio-system.metadata.0.name
  external_dns_sa_annotations = var.external_dns_sa_annotations
  external_dns_additional_args = var.external_dns_additional_args

  # Cloud DNS
  dns_name                 = var.dns_name
  external_dns_image       = "bitnami/external-dns:0.12.0"
  kubernetes_node_selector = {}
}

module "instances_external_dns" {
  source = "git::https://github.com/konpyutaika/terraform-external-dns-k8s.git/?ref=1.0.0"

  # Kubernetes
  kubernetes_cluster_name = var.kubernetes_cluster_name
  watch_istio = true

  # External-dns
  external_dns_namespace = kubernetes_namespace.instances.metadata.0.name
  external_dns_sa_annotations = var.external_dns_sa_annotations
  external_dns_additional_args = var.external_dns_additional_args

  # Cloud DNS
  dns_name                 =  var.dns_name
  external_dns_image       = "bitnami/external-dns:0.12.0"
  kubernetes_node_selector = {}
}