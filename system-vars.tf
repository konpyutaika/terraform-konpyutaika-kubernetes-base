variable "system_namespace" {
  description = "system's namespace"
  type        = string
  default     = "system"
}

variable "authservice_client_id" {
  description = "oidc service client id"
  type        = string
}

variable "authservice_client_secret" {
  description = "oidc client secret"
  type        = string
}

variable "authservice_issuer" {
  description = "oidc issuer"
  type        = string
}

variable "oidc_secret_ref" {
  description = "Kubernetes secret reference, for sensitives nifi properties"
  type        = object({
    namespace = string
    name      = string
    data      = string
  })
  default     = {
    namespace = ""
    name      = ""
    data      = ""
  }
}