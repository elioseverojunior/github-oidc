policy_statenent_deny = {
  actions = [
    "ce:*",
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
  Environemnt = "devlopment"
  Name        = "github-actions-assume-role"
}
