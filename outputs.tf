output "storage_class_name" {
  value = kubernetes_storage_class.ssd_wait.metadata[0].name
  description = "SSD wait storage class name"
}