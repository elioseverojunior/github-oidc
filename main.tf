resource "aws_iam_openid_connect_provider" "github_actions" {
  for_each        = var.create_oidc_provider ? toset(["enabled"]) : toset([])
  client_id_list  = var.github_actions_provider_configuration.client_id_list
  thumbprint_list = var.github_actions_provider_configuration.thumbprint_list
  url             = var.github_actions_provider_configuration.url
  tags            = { Name = "${var.environment}-github-actions-openid-connect-provider" }
}

resource "aws_iam_role" "github_actions" {
  depends_on            = [data.aws_iam_policy_document.github_actions_role_policy_document]
  for_each              = var.create_iam_roles ? local.github_subs_by_role : tomap({})
  name                  = "${title(var.environment)}${each.key}"
  description           = var.iam_role_description != "" && var.iam_role_description != null ? var.iam_role_description : "GitHub Actions IAM Role for ${var.environment} environment."
  assume_role_policy    = data.aws_iam_policy_document.github_actions_role_policy_document[each.key].json
  max_session_duration  = var.iam_role_max_session_duration
  force_detach_policies = var.force_detach_policies
  tags                  = { Name = "${var.environment}-github-actions-iam-role" }
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "${title(var.environment)}GitHubActionsIAMPolicies"
  description = "GitHub Actions IAM Policy for ${var.environment} environment."
  policy      = data.aws_iam_policy_document.github_actions_policy_document.json
  tags        = { Name = "${var.environment}-github-actions-policy" }
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attachment" {
  for_each   = var.create_iam_roles ? local.github_subs_by_role : tomap({})
  role       = aws_iam_role.github_actions[each.key].name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
