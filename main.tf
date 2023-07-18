module "alerts" {
  source = "./modules/alerts"

  alert_interval_seconds = var.alert_interval_seconds
  alert_rules            = var.alert_rules
}

module "contact_points" {
  source = "./modules/contact-points"

  slack_endpoints    = var.slack_endpoints
  opsgenie_endpoints = var.opsgenie_endpoints
}

module "notifications" {
  source = "./modules/notifications"

  slack_endpoints = var.notifications
}
