resource "aws_iam_openid_connect_provider" "github_actions" {
  for_each = var.create_oidc_provider ? toset(["enabled"]) : toset()
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
  url  = "https://token.actions.githubusercontent.com"
  tags = { Name = "openid-connect-provider-github-actions" }
}

module "github_actions_assumable_role" {
  depends_on = [aws_iam_openid_connect_provider.github_actions]
  source     = "./modules/github_actions_assumable_role"
  for_each   = var.create_iam_roles ? local.github_subs_by_role : {}

  github_subs       = each.value
  iam_role_name     = each.key
  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github_actions["enabled"].arn : var.oidc_provider_arn
  tags              = { Name = "github-actions-assumable-role" }
}

# tfsec:ignore:AVD-AWS-0057
data "aws_iam_policy_document" "github_actions_policy_document" {
  statement {
    sid       = "GitHubActionsAllowSelectedIAMPolicies"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid       = "GitHubActionsExplicityDenySelectedIAMPolicies"
    effect    = "Deny"
    actions   = var.policy_statenent_deny["actions"]
    resources = var.policy_statenent_deny["resources"]
  }
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "GitHubActionsIAMPolicies"
  description = "GitHub Actions IAM Policies"
  policy      = data.aws_iam_policy_document.github_actions_policy_document.json
  tags        = { Name = "github-actions-policy" }
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attachment" {
  role       = module.github_actions_assumable_role[var.assume_role_name].iam_role_name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
