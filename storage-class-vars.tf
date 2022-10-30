# Storage class
variable "ssd_storage_class_name" {
  description = "ssd_storage_class_name"
  type        = string
  default     = "ssd-wait"
}

variable "ssd_storage_provisioner" {
  description = "ssd storage class provisioner"
  type        = string
}


