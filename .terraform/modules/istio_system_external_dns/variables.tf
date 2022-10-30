# Kubernetes
variable "kubernetes_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "kubernetes_node_selector" {
  description = "Node selector config to restrict where pod should be deployed"
  type        = map(string)
}

# External-DNS
variable "external_dns_namespace" {
  description = "namespace where the external-dns will be deployed."
  type        = string
}

variable "external_dns_sa_annotations" {
  description = "A map of string to add as annotations."
  type        = map(string)
  default     = {}
}

variable "external_dns_additional_args" {
  description = "Additionals external DNS arguments."
  type        = list(string)
  default     = []
}

variable "dns_name" {
  description = "The DNS name associated to your dns zone."
  type        = string
}

variable "external_dns_image" {
  description = "Docker image to use"
  type        = string
}

variable "watch_istio" {
  description = "Whether or not external dns will also watch istio resources."
  type        = bool
  default     = false
}
