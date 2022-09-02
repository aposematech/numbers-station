variable "twitter_consumer_key_name" {
  description = "Twitter consumer key name"
  type        = string
  default     = ""
}

variable "twitter_consumer_key" {
  description = "Twitter consumer key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_consumer_secret_name" {
  description = "Twitter consumer secret name"
  type        = string
  default     = ""
}

variable "twitter_consumer_secret" {
  description = "Twitter consumer secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token_name" {
  description = "Twitter access token name"
  type        = string
  default     = ""
}

variable "twitter_access_token" {
  description = "Twitter access token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "twitter_access_token_secret_name" {
  description = "Twitter access token secret name"
  type        = string
  default     = ""
}

variable "twitter_access_token_secret" {
  description = "Twitter access token secret"
  type        = string
  default     = ""
  sensitive   = true
}
