locals {
  service_account_name = "cert-manager-sa"
}

module "cert_manager_role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name                     = "${var.stack}-cert-manager-role"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = [data.aws_route53_zone.zone.arn]
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${local.service_account_name}"]
    }
  }
}

resource "kubernetes_service_account" "cert-manager-sa" {
  metadata {
    name      = local.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.cert_manager_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
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
