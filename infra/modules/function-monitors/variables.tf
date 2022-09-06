variable "twitter_handle" {
  description = "Twitter Handle"
  type        = string
  default     = ""
}

variable "twitter_url" {
  description = "Twitter URL"
  type        = string
  default     = ""
}

variable "betteruptime_subdomain" {
  description = "Better Uptime Status Page Subdomain"
  type        = string
  default     = ""
}

variable "custom_status_page_subdomain" {
  description = "Custom Status Page Subdomain"
  type        = string
  default     = ""
}

variable "registered_domain_name" {
  description = "Route 53 Registered Domain Name"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
  default     = ""
}
