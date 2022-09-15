variable "secret_transmission_name" {
  description = "Secret Transmission - AWS Secret Name"
  type        = string
}

variable "secret_transmission_value" {
  description = "Secret Transmission - AWS Secret Value"
  type        = string
  sensitive   = true
}

variable "twitter_consumer_key_name" {
  description = "Twitter Consumer Key - AWS Secret Name"
  type        = string
}

variable "twitter_consumer_key_value" {
  description = "Twitter Consumer Key - AWS Secret Value"
  type        = string
  sensitive   = true
}

variable "twitter_consumer_secret_name" {
  description = "Twitter Consumer Secret - AWS Secret Name"
  type        = string
}

variable "twitter_consumer_secret_value" {
  description = "Twitter Consumer Secret - AWS Secret Value"
  type        = string
  sensitive   = true
}

variable "twitter_access_token_name" {
  description = "Twitter Access Token - AWS Secret Name"
  type        = string
}

variable "twitter_access_token_value" {
  description = "Twitter Access Token - AWS Secret Value"
  type        = string
  sensitive   = true
}

variable "twitter_access_token_secret_name" {
  description = "Twitter Access Token Secret - AWS Secret Name"
  type        = string
}

variable "twitter_access_token_secret_value" {
  description = "Twitter Access Token Secret AWS Secret Value"
  type        = string
  sensitive   = true
}
