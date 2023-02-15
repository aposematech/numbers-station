# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_heartbeat
resource "betteruptime_heartbeat" "heartbeat" {
  name   = var.betteruptime_heartbeat_name
  period = 3600
  grace  = 300
  email  = true
  paused = false
}
