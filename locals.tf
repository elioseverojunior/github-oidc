locals {
  permissions = {
    elioseverojunior : {
      repositories = {
        "*" : {
          role_name : var.assume_role_name
          allowed_branches : ["*"]
        }
      }
    },
    elioetibr : {
      repositories = {
        "*" : {
          role_name : var.assume_role_name
          allowed_branches : ["*"]
        }
      }
    },
    eliodevbr : {
      repositories = {
        "*" : {
          role_name : var.assume_role_name
          allowed_branches : ["*"]
        }
      }
    }
  }
  org_defaults = {}

  github_orgs = {
    for org_name, org_data in local.permissions : org_name => merge(local.org_defaults, org_data)
  }

  repo_defaults_by_org = {
    for org_name, org_data in local.github_orgs : org_name => {
      for key, val in org_data : key => val if key != "repositories"
    }
  }

  github_orgs_with_repos = {
    for org_name, org_data in local.github_orgs : org_name => merge(
      {
        for key, val in org_data : key => val if key != "repositories"
      },
      {
        "repositories" = {
          for repo_name, repo_data in org_data["repositories"] : repo_name => merge(local.repo_defaults_by_org[org_name], repo_data)
        }
      }
    )
  }

  # [{ github_subs, role_name }]
  github_subs = flatten([
    for org_name, org_data in local.github_orgs_with_repos : [
      for repo_name, repo_data in org_data["repositories"] : {
        role_name : repo_data["role_name"]
        github_subs : [
          for branch in repo_data["allowed_branches"] : format("repo:%s/%s:ref:refs/heads/%s", org_name, repo_name, branch)
      ] }
    ]
  ])

  github_subs_by_role = {
    for role in local.roles_names : role =>
    flatten(matchkeys([for el in local.github_subs : el["github_subs"]], [for el in local.github_subs : el["role_name"]], [role]))
  }

  roles_names = distinct([
    for el in local.github_subs : el["role_name"]
  ])
}
