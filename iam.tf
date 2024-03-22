resource "kubernetes_service_account" "cert-manager-sa" {
  metadata {
    name        = var.service_account_name
    namespace   = var.namespace
    annotations = var.service_account_annotations
  }
  secret {
    name = "${var.stack}-cert-manager-sa-secret"
  }
  automount_service_account_token = true
}


resource "kubernetes_secret" "sa-token" {
  type = "kubernetes.io/service-account-token"
  metadata {
    name      = tolist(kubernetes_service_account.cert-manager-sa.secret)[0].name
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.cert-manager-sa.metadata[0].name
    }
  }
}
