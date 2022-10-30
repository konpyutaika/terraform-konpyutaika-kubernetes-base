terraform {
  required_providers {
    google = {
      version = "4.21.0"
      source  = "hashicorp/google"
    }
    google-beta = {
      version = "4.21.0"
      source  = "hashicorp/google-beta"
    }
    helm = {
      version = "2.5.1"
      source  = "hashicorp/helm"
    }
    kubernetes = {
      version = "2.11.0"
      source  = "hashicorp/kubernetes"
    }
    kubernetes-alpha = {
      version = "0.6.0"
      source  = "hashicorp/kubernetes-alpha"
    }
  }
  required_version = ">= 1.1.0"
}