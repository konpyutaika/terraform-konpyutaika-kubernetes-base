# Squid System Space

## squid-system namespaces provisioning
resource "kubernetes_namespace" "front_office" {
  metadata {
    annotations = {
      name = var.front_office_namespace
#      "cnrm.cloud.google.com/project-id" = var.project_name
    }
    labels = {
      istio-injection = "enabled"
    }
    name = var.front_office_namespace
  }
}