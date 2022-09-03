terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "twitter_consumer_key" {
  name = var.twitter_consumer_key_name
}
resource "aws_secretsmanager_secret" "twitter_consumer_secret" {
  name = var.twitter_consumer_secret_name
}
resource "aws_secretsmanager_secret" "twitter_access_token" {
  name = var.twitter_access_token_name
}
resource "aws_secretsmanager_secret" "twitter_access_token_secret" {
  name = var.twitter_access_token_secret_name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version
resource "aws_secretsmanager_secret_version" "twitter_consumer_key_version" {
  secret_id     = aws_secretsmanager_secret.twitter_consumer_key.id
  secret_string = var.twitter_consumer_key_value
}
resource "aws_secretsmanager_secret_version" "twitter_consumer_secret_version" {
  secret_id     = aws_secretsmanager_secret.twitter_consumer_secret.id
  secret_string = var.twitter_consumer_secret_value
}
resource "aws_secretsmanager_secret_version" "twitter_access_token_version" {
  secret_id     = aws_secretsmanager_secret.twitter_access_token.id
  secret_string = var.twitter_access_token_value
}
resource "aws_secretsmanager_secret_version" "twitter_access_token_secret_version" {
  secret_id     = aws_secretsmanager_secret.twitter_access_token_secret.id
  secret_string = var.twitter_access_token_secret_value
}
