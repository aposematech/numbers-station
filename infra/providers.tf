# https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  # export GITHUB_TOKEN
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.aws_region
  # export AWS_ACCESS_KEY_ID
  # export AWS_SECRET_ACCESS_KEY

  default_tags {
    tags = {
      Terraform = "true"
      Workspace = terraform.workspace
    }
  }
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs
provider "betteruptime" {
  api_token = var.betteruptime_api_token
}
