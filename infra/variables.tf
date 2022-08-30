variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "account_number" {
  description = "AWS account number"
  type        = string
  default     = ""
}

variable "twitter_consumer_key" {
  description = "Twitter consumer key"
  type        = string
  default     = ""
}

variable "twitter_consumer_secret" {
  description = "Twitter consumer secret"
  type        = string
  default     = ""
}

variable "twitter_access_token" {
  description = "Twitter access token"
  type        = string
  default     = ""
}

variable "twitter_access_token_secret" {
  description = "Twitter access token secret"
  type        = string
  default     = ""
}

variable "cron" {
  description = "Cron expression"
  type        = string
  default     = "cron(49 * * * ? *)"
}
