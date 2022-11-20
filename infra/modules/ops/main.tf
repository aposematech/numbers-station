terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.0"
    }
  }
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_heartbeat
resource "betteruptime_heartbeat" "heartbeat" {
  name   = var.betteruptime_heartbeat_name
  period = 3600
  grace  = 300
  email  = true
  paused = false
}
