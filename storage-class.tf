# Storage class
resource "kubernetes_storage_class" "ssd_wait" {
  // Add create param
  reclaim_policy      = "Delete"
  storage_provisioner = var.ssd_storage_provisioner
  volume_binding_mode = "WaitForFirstConsumer"

  parameters = {
    type = "pd-ssd"
  }

  metadata {
    annotations      = {}
    labels           = {}
    name             = var.ssd_storage_class_name
  }
}