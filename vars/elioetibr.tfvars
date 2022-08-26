assume_role_name     = "GitHubOrganizationAccountAssumeRole"
environment          = "prod"
create_oidc_provider = true
github_actions_provider_configuration = {
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
  url = "https://token.actions.githubusercontent.com"
}
github_repositories_map = {
  elioseverojunior = {
    repositories = {
      "*" = {
        role_name        = null
        allowed_branches = ["*"]
      }
    }
  }
  elioetibr = {
    repositories = {
      "*" = {
        role_name        = null
        allowed_branches = ["*"]
      }
    }
  }
  eliodevbr = {
    repositories = {
      "*" = {
        role_name        = null
        allowed_branches = ["*"]
      }
    }
  }
}
policy_statement_deny = {
  actions = [
    "ce:*",
    "iam:DeleteUserPermissionsBoundary",
    "iam:DeleteVirtualMFADevice",
    "iam:PassRole",
  ]
  resources = ["*"]
}
tags = {
  market      = "BR"
  environment = "production"
}
