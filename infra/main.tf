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
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.region
}

module "numbers_station" {
  source                      = "./modules/numbers-station"
  region                      = var.region
  account_number              = var.account_number
  cron                        = var.cron
  twitter_consumer_key        = var.twitter_consumer_key
  twitter_consumer_secret     = var.twitter_consumer_secret
  twitter_access_token        = var.twitter_access_token
  twitter_access_token_secret = var.twitter_access_token_secret
}
