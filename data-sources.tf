/*
  AWS Data Sources
*/
data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

/*
  Policy Documents
*/
data "aws_iam_openid_connect_provider" "github_actions" {
  for_each = var.create_oidc_provider ? toset([]) : toset(["enabled"])
  url      = var.github_actions_provider_configuration.url
}

data "aws_iam_policy_document" "github_actions_policy_document" {
  statement {
    sid       = "${title(var.environment)}GitHubActionsAllowSelectedIAMPolicies"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid       = "${title(var.environment)}GitHubActionsExplicityDenySelectedIAMPolicies"
    effect    = "Deny"
    actions   = var.policy_statement_deny["actions"]
    resources = var.policy_statement_deny["resources"]
  }
}

data "aws_iam_policy_document" "github_actions_role_policy_document" {
  for_each = var.create_iam_roles ? local.github_subs_by_role : tomap({})
  statement {
    sid    = "${title(var.environment)}${each.key}"
    effect = "Allow"
    principals {
      identifiers = [local.aws_iam_openid_connect_provider.arn]
      type        = "Federated"
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      values   = each.value
      variable = "${replace(replace(var.github_actions_provider_configuration.url, "http://", ""), "https://", "")}:sub"
    }
  }
}
