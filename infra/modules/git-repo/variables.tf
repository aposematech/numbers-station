variable "git_repo_description" {
  description = "Repo description"
  type        = string
  default     = ""
}

variable "git_repo_homepage_url" {
  description = "Repo homepage URL"
  type        = string
  default     = ""
}

variable "git_repo_visibility" {
  description = "Repo visibility"
  type        = string
  default     = ""
}

variable "git_secret_name_aws_access_key_id" {
  description = "GitHub Actions secret name: AWS access key id"
  type        = string
  default     = ""
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
  default     = ""
}

variable "git_secret_aws_access_key" {
  description = "GitHub Actions secret: AWS access key"
  type        = string
  default     = ""
  sensitive   = true
}
