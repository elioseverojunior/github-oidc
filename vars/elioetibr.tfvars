policy_statenent_deny = {
  actions = [
    "ce:*",
    "iam:CreateAccessKey",
    "iam:CreateAccountAlias",
    "iam:CreateServiceLinkedRole",
    "iam:CreateVirtualMFADevice",
    "iam:DeleteUserPermissionsBoundary",
    "iam:DeleteVirtualMFADevice",
    "iam:PassRole",
  ]
  resources = ["*"]
}
tags = {
  Country     = "BR"
  Environemnt = "production"
  Name        = "github-actions-assume-role"
}
