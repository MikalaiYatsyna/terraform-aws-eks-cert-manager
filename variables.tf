variable "stack" {
  type        = string
  description = "Stack name"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "domain" {
  type        = string
  description = "Root application domain name"
}

variable "namespace" {
  type        = string
  description = "Namespace for Vault release"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider arn"
}
