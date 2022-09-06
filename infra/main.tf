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
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.0"
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
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs
provider "betteruptime" {
  api_token = var.betteruptime_api_token
}

module "git_repo" {
  source                  = "./modules/git-repo"
  git_repo_name           = terraform.workspace
  git_repo_description    = var.git_repo_description
  git_repo_homepage_url   = var.twitter_url
  git_repo_visibility     = var.git_repo_visibility
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
  aws_region_name         = "AWS_REGION"
  aws_region_value        = var.aws_region
}

module "image_repo" {
  source          = "./modules/image-repo"
  image_repo_name = module.git_repo.git_repo_name
}

module "function_secrets" {
  source                            = "./modules/function-secrets"
  secret_transmission_name          = "SECRET_TRANSMISSION"
  secret_transmission_value         = var.secret_transmission
  twitter_consumer_key_name         = "TWITTER_CONSUMER_KEY"
  twitter_consumer_key_value        = var.twitter_consumer_key
  twitter_consumer_secret_name      = "TWITTER_CONSUMER_SECRET"
  twitter_consumer_secret_value     = var.twitter_consumer_secret
  twitter_access_token_name         = "TWITTER_ACCESS_TOKEN"
  twitter_access_token_value        = var.twitter_access_token
  twitter_access_token_secret_name  = "TWITTER_ACCESS_TOKEN_SECRET"
  twitter_access_token_secret_value = var.twitter_access_token_secret
}

module "lambda_function" {
  source                           = "./modules/lambda-function"
  function_name                    = module.image_repo.image_repo_name
  aws_region                       = var.aws_region
  aws_account_number               = var.aws_account_number
  cron                             = var.cron
  secret_transmission_name         = module.function_secrets.secret_transmission_name
  secret_transmission_arn          = module.function_secrets.secret_transmission_arn
  twitter_consumer_key_name        = module.function_secrets.twitter_consumer_key_name
  twitter_consumer_key_arn         = module.function_secrets.twitter_consumer_key_arn
  twitter_consumer_secret_name     = module.function_secrets.twitter_consumer_secret_name
  twitter_consumer_secret_arn      = module.function_secrets.twitter_consumer_secret_arn
  twitter_access_token_name        = module.function_secrets.twitter_access_token_name
  twitter_access_token_arn         = module.function_secrets.twitter_access_token_arn
  twitter_access_token_secret_name = module.function_secrets.twitter_access_token_secret_name
  twitter_access_token_secret_arn  = module.function_secrets.twitter_access_token_secret_arn
  heartbeat_monitor_url            = module.function_monitors.heartbeat_monitor_url
}

module "function_domain" {
  source                 = "./modules/function-domain"
  registered_domain_name = var.registered_domain_name
}

module "function_monitors" {
  source                       = "./modules/function-monitors"
  twitter_handle               = var.twitter_handle
  twitter_url                  = var.twitter_url
  betteruptime_subdomain       = var.betteruptime_subdomain
  custom_status_page_subdomain = var.custom_status_page_subdomain
  registered_domain_name       = module.function_domain.registered_domain_name
  hosted_zone_id               = module.function_domain.hosted_zone_id
}
