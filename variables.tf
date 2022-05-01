variable "assume_role_name" {
  description = "AWS IAM Assume Role Name"
  type        = string
  default     = "GitHubOrganizationAccountAccessRole"
}

variable "create_oidc_provider" {
  description = "Whether or not to create the associated oidc provider. If true, variable 'oidc_provider_arn' is required"
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "Used if create_oidc_provider is true"
  type        = string
  default     = ""
}

variable "create_iam_roles" {
  description = "Whether or not to create IAM roles."
  type        = bool
  default     = true
}

variable "policy_statenent_deny" {
  description = "Policy Stament Deny"
  type = object({
    actions   = list(string)
    resources = list(string)
  })
  default = {
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
}

variable "tags" {
  description = "AWS Tags"
  type        = map(any)
  default = {
    Country     = "BR"
    Environemnt = "dev"
    Name        = "github-actions-assume-role"
  }
}
