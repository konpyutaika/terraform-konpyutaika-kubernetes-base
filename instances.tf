resource "kubernetes_namespace" "instances" {
  metadata {
    annotations = {
      name                               = var.instances_namespace
#      "cnrm.cloud.google.com/project-id" = var.project_name
    }
    name = var.instances_namespace
  }
}