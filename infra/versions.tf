terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.16.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.15"
    }
  }

  required_version = "~> 1.3.7"
}
