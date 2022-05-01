# GitHub Actions AWS IAM Assume Role with Provider OIDC

## Pre-Requirements

### Terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0, < 5.0.0 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github_actions_assumable_role"></a> [github\_actions\_assumable\_role](#module\_github\_actions\_assumable\_role) | ./modules/github_actions_assumable_role | n/a |

#### Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.github_actions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.github_actions_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.github_actions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_name"></a> [assume\_role\_name](#input\_assume\_role\_name) | AWS IAM Assume Role Name | `string` | `"GitHubOrganizationAccountAccessRole"` | no |
| <a name="input_create_iam_roles"></a> [create\_iam\_roles](#input\_create\_iam\_roles) | Whether or not to create IAM roles. | `bool` | `true` | no |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Whether or not to create the associated oidc provider. If true, variable 'oidc\_provider\_arn' is required | `bool` | `true` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | Used if create\_oidc\_provider is true | `string` | `""` | no |
| <a name="input_policy_statenent_deny"></a> [policy\_statenent\_deny](#input\_policy\_statenent\_deny) | Policy Stament Deny | <pre>object({<br>    actions   = list(string)<br>    resources = list(string)<br>  })</pre> | <pre>{<br>  "actions": [<br>    "ce:*",<br>    "iam:CreateAccessKey",<br>    "iam:CreateAccountAlias",<br>    "iam:CreateServiceLinkedRole",<br>    "iam:CreateVirtualMFADevice",<br>    "iam:DeleteUserPermissionsBoundary",<br>    "iam:DeleteVirtualMFADevice",<br>    "iam:PassRole"<br>  ],<br>  "resources": [<br>    "*"<br>  ]<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags | `map(any)` | <pre>{<br>  "Country": "BR",<br>  "Environemnt": "dev",<br>  "Name": "github-actions-assume-role"<br>}</pre> | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_actions_assume_role_name"></a> [github\_actions\_assume\_role\_name](#output\_github\_actions\_assume\_role\_name) | GitHub Actions AssumeRole Name |
| <a name="output_github_actions_iam_policy"></a> [github\_actions\_iam\_policy](#output\_github\_actions\_iam\_policy) | n/a |
| <a name="output_github_actions_policy_data"></a> [github\_actions\_policy\_data](#output\_github\_actions\_policy\_data) | n/a |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Roles to be assumed by github actions |
| <a name="output_iam_roles"></a> [iam\_roles](#output\_iam\_roles) | Roles to be assumed by github actions |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | OIDC provider ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Elio Severo Junior
