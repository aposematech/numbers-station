terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "secret_transmission" {
  name        = var.secret_transmission_name
  type        = "SecureString"
  value       = var.secret_transmission_value
}

resource "aws_ssm_parameter" "twitter_consumer_key" {
  name        = var.twitter_consumer_key_name
  type        = "SecureString"
  value       = var.twitter_consumer_key_value
}

resource "aws_ssm_parameter" "twitter_consumer_secret" {
  name        = var.twitter_consumer_secret_name
  type        = "SecureString"
  value       = var.twitter_consumer_secret_value
}

resource "aws_ssm_parameter" "twitter_access_token" {
  name        = var.twitter_access_token_name
  type        = "SecureString"
  value       = var.twitter_access_token_value
}

resource "aws_ssm_parameter" "twitter_access_token_secret" {
  name        = var.twitter_access_token_secret_name
  type        = "SecureString"
  value       = var.twitter_access_token_secret_value
}
