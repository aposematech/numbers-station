# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
resource "github_repository" "git_repo" {
  name         = terraform.workspace
  description  = var.git_repo_description
  homepage_url = var.git_repo_homepage_url
  visibility   = var.git_repo_visibility
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret
data "github_actions_public_key" "git_repo_public_key" {
  repository = terraform.workspace
}

resource "github_actions_secret" "git_secret_aws_access_key_id" {
  repository      = terraform.workspace
  secret_name     = var.git_secret_name_aws_access_key_id
  plaintext_value = var.git_secret_aws_access_key_id
}

resource "github_actions_secret" "git_secret_aws_access_key" {
  repository      = terraform.workspace
  secret_name     = var.git_secret_name_aws_access_key
  plaintext_value = var.git_secret_aws_access_key
}
