variable "aws_access_key_id" {
  description = "AWS Access Key ID - GitHub Actions Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_access_key" {
  description = "AWS Access Key - GitHub Actions Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
  default     = ""
}

variable "twitter_consumer_key" {
  description = "Twitter Consumer Key - AWS Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_consumer_secret" {
  description = "Twitter Consumer Secret - AWS Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token" {
  description = "Twitter Access Token - AWS Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token_secret" {
  description = "Twitter Access Token Secret - AWS Secret"
  type        = string
  default     = ""
  sensitive   = true
}
