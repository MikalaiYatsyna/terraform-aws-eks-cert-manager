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

variable "email" {
  type        = string
  description = "Email to be used in acme"
}

variable "acme_server" {
  type        = string
  description = "ACME server to user"
  default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "hosted_zone_id" {
  type        = string
  description = "Hosted zone ID to use for challenges"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider arn"
}
