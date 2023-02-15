terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.15"
    }
  }

  required_version = "~> 1.3.7"
}
