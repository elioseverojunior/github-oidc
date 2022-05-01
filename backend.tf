terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "eliodevbr"
    workspaces {
      name = "github-oidc-dev"
    }
  }
}
