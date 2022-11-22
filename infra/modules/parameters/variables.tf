variable "secret_transmission_name" {
  description = "Secret Transmission - AWS Secret Name"
  type        = string
}

variable "secret_transmission_value" {
  description = "Secret Transmission - AWS Secret Value"
  type        = string
  sensitive   = true
}
