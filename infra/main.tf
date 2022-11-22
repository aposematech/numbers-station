terraform {
  # https://www.terraform.io/language/settings/terraform-cloud
  cloud {
    organization = "djfav"
    workspaces {
      name = "numbers-station"
    }
  }

  # https://www.terraform.io/language/providers/requirements
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.9.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.13"
    }
  }
}

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

module "git" {
  source                  = "./modules/git"
  git_repo_name           = terraform.workspace
  git_repo_description    = var.git_repo_description
  git_repo_homepage_url   = var.git_repo_homepage_url
  git_repo_topics         = ["bot", "demo"]
  git_repo_visibility     = var.git_repo_visibility
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
  aws_region_name         = "AWS_REGION"
  aws_region_value        = var.aws_region
}

module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = terraform.workspace
}

module "parameters" {
  source                    = "./modules/parameters"
  secret_transmission_name  = "SECRET_TRANSMISSION"
  secret_transmission_value = var.secret_transmission
}

module "lambda" {
  source                   = "./modules/lambda"
  function_name            = terraform.workspace
  aws_region               = var.aws_region
  aws_account_number       = var.aws_account_number
  cron                     = var.cron
  secret_transmission_name = module.parameters.secret_transmission_name
  secret_transmission_arn  = module.parameters.secret_transmission_arn
  website_bucket_name      = module.web.website_bucket_name
  website_bucket_arn       = module.web.website_bucket_arn
  heartbeat_monitor_url    = module.ops.heartbeat_monitor_url
}

module "web" {
  source                 = "./modules/web"
  registered_domain_name = var.registered_domain_name
}

module "ops" {
  source                      = "./modules/ops"
  betteruptime_heartbeat_name = terraform.workspace
}
