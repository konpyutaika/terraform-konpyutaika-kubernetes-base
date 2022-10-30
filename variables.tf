# Common variables
## GCP Configurations
variable "project_name" {
  description = "GCP project name"
  type        = string
}

## Kubernetes
variable "kubernetes_cluster_name" {
  description = "Kubernetes cluster name"
  type = string
}
