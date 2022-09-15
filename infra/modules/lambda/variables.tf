variable "function_name" {
  description = "Lambda Function Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
}

variable "cron" {
  description = "Cron Expression"
  type        = string
}

variable "secret_transmission_name" {
  description = "Secret Transmission - AWS Secret Name"
  type        = string
}

variable "secret_transmission_arn" {
  description = "Secret Transmission - AWS Secret ARN"
  type        = string
}

variable "twitter_consumer_key_name" {
  description = "Twitter Consumer Key - AWS Secret Name"
  type        = string
}

variable "twitter_consumer_key_arn" {
  description = "Twitter Consumer Key - AWS Secret ARN"
  type        = string
}

variable "twitter_consumer_secret_name" {
  description = "Twitter Consumer Secret - AWS Secret Name"
  type        = string
}

variable "twitter_consumer_secret_arn" {
  description = "Twitter Consumer Secret - AWS Secret ARN"
  type        = string
}

variable "twitter_access_token_name" {
  description = "Twitter Access Token - AWS Secret Name"
  type        = string
}

variable "twitter_access_token_arn" {
  description = "Twitter Access Token - AWS Secret ARN"
  type        = string
}

variable "twitter_access_token_secret_name" {
  description = "Twitter Access Token Secret - AWS Secret Name"
  type        = string
}

variable "twitter_access_token_secret_arn" {
  description = "Twitter Access Token Secret - AWS Secret ARN"
  type        = string
}
