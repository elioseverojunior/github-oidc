# GitHub Actions AWS IAM Assume Role with Provider OIDC

## Pre-Requirements

### Terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.github_actions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.github_actions_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.github_actions_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.github_actions_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_name"></a> [assume\_role\_name](#input\_assume\_role\_name) | AWS IAM Assume Role Name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_github_actions_provider_configuration"></a> [github\_actions\_provider\_configuration](#input\_github\_actions\_provider\_configuration) | OpenID Connect Provider Configuration | <pre>object({<br>    client_id_list  = list(string)<br>    thumbprint_list = list(string)<br>    url             = string<br>  })</pre> | n/a | yes |
| <a name="input_github_repositories_map"></a> [github\_repositories\_map](#input\_github\_repositories\_map) | AWS IAM Detach Policies | <pre>map(object({<br>    repositories = map(object({<br>      role_name        = string<br>      allowed_branches = list(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_policy_statement_deny"></a> [policy\_statement\_deny](#input\_policy\_statement\_deny) | Policy Statement Deny | <pre>object({<br>    actions   = list(string)<br>    resources = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags | `map(any)` | n/a | yes |
| <a name="input_create_iam_roles"></a> [create\_iam\_roles](#input\_create\_iam\_roles) | Whether or not to create IAM Role. | `bool` | `true` | no |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Whether or not to create the associated oidc provider. If true, variable 'oidc\_provider\_arn' is required | `bool` | `true` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | AWS IAM Detach Policies | `bool` | `true` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | AWS IAM Role Description | `string` | `"GitHub Organization Account Assume Role"` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | Max Session Duration in Seconds | `number` | `7200` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | ARN of the github actions AWS oidc provider. Used if create\_oidc\_provider is true | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_actions_policy_document"></a> [github\_actions\_policy\_document](#output\_github\_actions\_policy\_document) | GitHub Actions IAM Policy Document |
| <a name="output_github_actions_role"></a> [github\_actions\_role](#output\_github\_actions\_role) | GitHub Actions Role |
| <a name="output_github_actions_role_policy_document"></a> [github\_actions\_role\_policy\_document](#output\_github\_actions\_role\_policy\_document) | GitHub Actions Role Policy Document |
| <a name="output_github_subs_by_role"></a> [github\_subs\_by\_role](#output\_github\_subs\_by\_role) | GitHub Subs By Role |
| <a name="output_iam_github_actions_provider"></a> [iam\_github\_actions\_provider](#output\_iam\_github\_actions\_provider) | GitHub Actions IAM OpenID Connect |
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role) | AWS IAM role |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the created IAM Role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the created IAM Role |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | OIDC provider ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Elio Severo Junior
