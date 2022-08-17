policy_statenent_deny = {
  actions = [
    "ce:*",
    "iam:DeleteUserPermissionsBoundary",
    "iam:DeleteVirtualMFADevice",
    "iam:PassRole",
  ]
  resources = ["*"]
}
tags = {
  Country     = "BR"
  Environemnt = "devlopment"
  Name        = "github-actions-assume-role-dev"
}
