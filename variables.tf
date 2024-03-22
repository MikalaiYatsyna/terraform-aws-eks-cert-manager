variable "stack" {
  type        = string
  description = "Stack name"
}

variable "namespace" {
  type        = string
  description = "Namespace for Vault release"
}

variable "cluster_endpoint" {
  sensitive   = true
  type        = string
  description = "Endpoint of the cluster."
}

variable "cluster_ca" {
  sensitive   = true
  type        = string
  description = "CA certificate of the cluster."
}

variable "k8s_exec_args" {
  type        = list(string)
  description = "Args for Kubernetes provider exec plugin. Example command ['eks', 'get-token', '--cluster-name', '{clusterName}}']."
}

variable "k8s_exec_command" {
  type        = string
  description = "Command name for Kubernetes provider exec plugin. Example - 'aws."
}

variable "service_account_name" {
  type = string
  description = "Kubernetes service account name, to be created and used for cert-manager."
}

variable "service_account_annotations" {
  type = map(string)
  description = "Annotations to be applied to service account. e.g 'eks.amazonaws.com/sts-regional-endpoints' = 'true'."
}
