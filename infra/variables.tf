variable "git_repo_description" {
  description = "Repo description"
  type        = string
  default     = "Twitter bot demo"
}

variable "git_repo_homepage_url" {
  description = "Repo homepage URL"
  type        = string
  default     = "https://twitter.com/CharlieSierra49"
}

variable "git_repo_visibility" {
  description = "Repo visibility"
  type        = string
  default     = "public"
}

variable "git_secret_name_aws_access_key_id" {
  description = "GitHub Actions secret name: AWS access key id"
  type        = string
  default     = "AWS_ACCESS_KEY_ID"
}

variable "git_secret_aws_access_key_id" {
  description = "GitHub Actions secret: AWS access key id"
  type        = string
  default     = ""
  sensitive   = true
}

variable "git_secret_name_aws_access_key" {
  description = "GitHub Actions secret name: AWS access key"
  type        = string
  default     = "AWS_SECRET_ACCESS_KEY"
}

variable "git_secret_aws_access_key" {
  description = "GitHub Actions secret: AWS access key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_number" {
  description = "AWS account number"
  type        = string
  default     = ""
}

variable "cron" {
  description = "Cron expression"
  type        = string
  default     = "cron(49 * * * ? *)"
}

variable "twitter_consumer_key" {
  description = "Twitter consumer key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_consumer_secret" {
  description = "Twitter consumer secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token" {
  description = "Twitter access token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token_secret" {
  description = "Twitter access token secret"
  type        = string
  default     = ""
  sensitive   = true
}
