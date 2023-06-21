module "alerts" {
  source = "./modules/alerts"

  interval_seconds = var.interval_seconds
  alert_rules      = var.alert_rules
}
