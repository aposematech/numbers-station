variable "function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
  default     = ""
}

variable "cron" {
  description = "Cron Expression"
  type        = string
  default     = ""
}

variable "secret_transmission_name" {
  description = "Secret Transmission - AWS Secret Name"
  type        = string
  default     = ""
}

variable "secret_transmission_arn" {
  description = "Secret Transmission - AWS Secret ARN"
  type        = string
  default     = ""
}

variable "twitter_consumer_key_name" {
  description = "Twitter Consumer Key - AWS Secret Name"
  type        = string
  default     = ""
}

variable "twitter_consumer_key_arn" {
  description = "Twitter Consumer Key - AWS Secret ARN"
  type        = string
  default     = ""
}

variable "twitter_consumer_secret_name" {
  description = "Twitter Consumer Secret - AWS Secret Name"
  type        = string
  default     = ""
}

variable "twitter_consumer_secret_arn" {
  description = "Twitter Consumer Secret - AWS Secret ARN"
  type        = string
  default     = ""
}

variable "twitter_access_token_name" {
  description = "Twitter Access Token - AWS Secret Name"
  type        = string
  default     = ""
}

variable "twitter_access_token_arn" {
  description = "Twitter Access Token - AWS Secret ARN"
  type        = string
  default     = ""
}

variable "twitter_access_token_secret_name" {
  description = "Twitter Access Token Secret - AWS Secret Name"
  type        = string
  default     = ""
}

variable "twitter_access_token_secret_arn" {
  description = "Twitter Access Token Secret - AWS Secret ARN"
  type        = string
  default     = ""
}

variable "heartbeat_monitor_url" {
  description = "Better Uptime Heartbeat Monitor URL"
  type        = string
  default     = ""
}
