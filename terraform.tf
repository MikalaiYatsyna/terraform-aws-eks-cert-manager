terraform {
  required_version = "1.7.5"
  required_providers {
    kubernetes = {
      version = "2.27.0"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "2.13.0"
      source  = "hashicorp/helm"
    }
  }
}
