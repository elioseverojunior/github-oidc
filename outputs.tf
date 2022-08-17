output "iam_roles" {
  description = "Roles to be assumed by github actions"
  value       = module.github_actions_assumable_role
}

output "iam_role_name" {
  description = "Roles to be assumed by github actions"
  value       = module.github_actions_assumable_role[var.assume_role_name].iam_role_name
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = var.create_oidc_provider ? aws_iam_openid_connect_provider.github_actions["enabled"].arn : var.oidc_provider_arn
}

output "github_actions_assume_role_name" {
  description = "GitHub Actions AssumeRole Name"
  value       = var.assume_role_name
}

output "github_actions_policy_data" {
  value = data.aws_iam_policy_document.github_actions_policy_document.json
}

output "github_actions_iam_policy" {
  value = aws_iam_policy.github_actions_policy
}
