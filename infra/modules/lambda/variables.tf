variable "function_name" {
  description = "Lambda Function Name"
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

variable "cron" {
  description = "Cron Expression"
  type        = string
}

variable "secret_transmission_name" {
  description = "Secret Transmission - AWS  Parameter Store Name"
  type        = string
}

variable "secret_transmission_arn" {
  description = "Secret Transmission - AWS Parameter Store ARN"
  type        = string
}

variable "website_bucket_name" {
  description = "S3 Website Bucket Name"
  type        = string
}

variable "website_bucket_arn" {
  description = "S3 Website Bucket ARN"
  type        = string
}

variable "bucket_folder_name" {
  description = "S3 Bucket Folder Name"
  type        = string
}

variable "heartbeat_monitor_url" {
  description = "Better Uptime Heartbeat Monitor URL"
  type        = string
  default     = ""
}
