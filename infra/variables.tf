variable "region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "account_number" {
  description = "AWS account number"
  type        = string
  default     = ""
}

variable "twitter_consumer_key" {
  description = "Twitter Consumer Key"
  type        = string
  default     = ""
}

variable "twitter_consumer_secret" {
  description = "Twitter Consumer Secret"
  type        = string
  default     = ""
}

variable "twitter_access_token" {
  description = "Twitter Access Token"
  type        = string
  default     = ""
}

variable "twitter_access_token_secret" {
  description = "Twitter Access Token Secret"
  type        = string
  default     = ""
}

variable "cron" {
  description = "Cron Expression"
  type        = string
  default     = ""
}
