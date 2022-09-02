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
  }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.aws_region
}

module "git_repo" {
  source                  = "./modules/git-repo"
  git_repo_description    = "Twitter bot demo"
  git_repo_homepage_url   = "https://twitter.com/CharlieSierra49"
  git_repo_visibility     = "public"
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
}

module "image_repo" {
  source = "./modules/image-repo"
}

module "function_secrets" {
  source                            = "./modules/function-secrets"
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
  aws_region                       = var.aws_region
  aws_account_number               = var.aws_account_number
  cron                             = "cron(49 * * * ? *)"
  twitter_consumer_key_name        = module.function_secrets.twitter_consumer_key_name
  twitter_consumer_key_arn         = module.function_secrets.twitter_consumer_key_arn
  twitter_consumer_secret_name     = module.function_secrets.twitter_consumer_secret_name
  twitter_consumer_secret_arn      = module.function_secrets.twitter_consumer_secret_arn
  twitter_access_token_name        = module.function_secrets.twitter_access_token_name
  twitter_access_token_arn         = module.function_secrets.twitter_access_token_arn
  twitter_access_token_secret_name = module.function_secrets.twitter_access_token_secret_name
  twitter_access_token_secret_arn  = module.function_secrets.twitter_access_token_secret_arn
}
