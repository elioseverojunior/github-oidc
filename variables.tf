variable "assume_role_name" {
  description = "AWS IAM Assume Role Name"
  type        = string
}

variable "create_oidc_provider" {
  description = "Whether or not to create the associated oidc provider. If true, variable 'oidc_provider_arn' is required"
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "ARN of the github actions AWS oidc provider. Used if create_oidc_provider is true"
  type        = string
  default     = null
}

variable "create_iam_roles" {
  description = "Whether or not to create IAM Role."
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "github_actions_provider_configuration" {
  description = "OpenID Connect Provider Configuration"
  type = object({
    client_id_list  = list(string)
    thumbprint_list = list(string)
    url             = string
  })
}

variable "github_repositories_map" {
  description = "AWS IAM Detach Policies"
  type = map(object({
    repositories = map(object({
      role_name        = string
      allowed_branches = list(string)
    }))
  }))
}

variable "policy_statement_deny" {
  description = "Policy Statement Deny"
  type = object({
    actions   = list(string)
    resources = list(string)
  })
}

variable "iam_role_description" {
  description = "AWS IAM Role Description"
  type        = string
  default     = "GitHub Organization Account Assume Role"
}

variable "iam_role_max_session_duration" {
  description = "Max Session Duration in Seconds"
  type        = number
  validation {
    condition     = (var.iam_role_max_session_duration >= 3600 && var.iam_role_max_session_duration < 43200)
    error_message = "Invalid IAM Role Max Session Duration value. It must be greater or equal than \"3600\" (1 hour) and less than \"43200\" (12 hours)."
  }
  default = 7200
}

variable "force_detach_policies" {
  description = "AWS IAM Detach Policies"
  type        = bool
  default     = true
}

variable "tags" {
  description = "AWS Tags"
  type        = map(any)
}
