terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      version = "4.57.1"
      source  = "hashicorp/aws"
    }
    kubernetes = {
      version = "2.18.1"
      source  = "hashicorp/kubernetes"
    }
    helm = {
      version = "2.9.0"
      source  = "hashicorp/helm"
    }
  }
}
