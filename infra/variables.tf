variable "git_repo_description" {
  description = "GitHub Repo Description"
  type        = string
}

variable "git_repo_visibility" {
  description = "GitHub Repo Visibility"
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

variable "aws_access_key_id" {
  description = "AWS Access Key ID - GitHub Actions Secret"
  type        = string
  sensitive   = true
}

variable "aws_access_key" {
  description = "AWS Access Key - GitHub Actions Secret"
  type        = string
  sensitive   = true
}

variable "cron" {
  description = "Cron Expression"
  type        = string
}

variable "secret_transmission" {
  description = "Secret Transmission - AWS Secret"
  type        = string
  sensitive   = true
}

variable "twitter_handle" {
  description = "Twitter Handle"
  type        = string
}

variable "twitter_url" {
  description = "Twitter URL"
  type        = string
}

variable "twitter_consumer_key" {
  description = "Twitter Consumer Key - AWS Secret"
  type        = string
  sensitive   = true
}

variable "twitter_consumer_secret" {
  description = "Twitter Consumer Secret - AWS Secret"
  type        = string
  sensitive   = true
}

variable "twitter_access_token" {
  description = "Twitter Access Token - AWS Secret"
  type        = string
  sensitive   = true
}

variable "twitter_access_token_secret" {
  description = "Twitter Access Token Secret - AWS Secret"
  type        = string
  sensitive   = true
}

variable "betteruptime_api_token" {
  description = "Better Uptime API Token"
  type        = string
  default     = ""
  sensitive   = true
}
