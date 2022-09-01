# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
resource "github_repository" "repo" {
  name         = var.repo_name
  description  = var.repo_description
  homepage_url = var.repo_homepage_url
  visibility   = var.repo_visibility
}
