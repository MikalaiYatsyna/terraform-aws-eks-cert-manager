data "aws_iam_policy_document" "change_policy" {
  statement {
    sid       = "route53"
    actions   = ["route53:GetChange"]
    resources = ["arn:aws:route53:::change/*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "update_zone_policy" {
  statement {
    sid = "route53"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = ["arn:aws:route53:::hostedzone/*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "list_zones" {
  statement {
    sid       = "route53"
    actions   = ["route53:ListHostedZonesByName"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "change" {
  policy = data.aws_iam_policy_document.change_policy.json
}
resource "aws_iam_policy" "list_zone" {
  policy = data.aws_iam_policy_document.list_zones.json
}
resource "aws_iam_policy" "update_zone" {
  policy = data.aws_iam_policy_document.update_zone_policy.json
}

module "cert_manager_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${var.stack}-cert-manager-role"
  role_policy_arns = {
    Change     = aws_iam_policy.change.arn
    UpdateZone = aws_iam_policy.update_zone.arn
    ListZones  = aws_iam_policy.list_zone.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${var.stack}-cert-manager-sa"]
    }
  }
}

resource "kubernetes_service_account" "secret-manager-sa" {
  metadata {
    name      = "${var.stack}-cert-manager-sa"
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
    name      = "${kubernetes_service_account.secret-manager-sa.metadata[0].name}-secret"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.secret-manager-sa.metadata[0].name
    }
  }
}
