variable "dns_name" {
  description = "The DNS name associated to your dns zone."
  type        = string
}

variable "external_dns_additional_args" {
  description = "Additionals external DNS arguments."
  type        = list(string)
  default     = []
}

variable "external_dns_sa_annotations" {
  description = "A map of string to add as annotations."
  type        = map(string)
  default     = {}
}