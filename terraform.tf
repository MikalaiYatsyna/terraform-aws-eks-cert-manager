terraform {
  required_version = "1.7.5"
  required_providers {
    kubernetes = {
      version = "2.28.0"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "2.12.1"
      source  = "hashicorp/helm"
    }
  }
}
