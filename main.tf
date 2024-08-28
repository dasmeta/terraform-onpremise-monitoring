module "alerts" {
  source = "./modules/alerts"

  alert_interval_seconds = var.alert_interval_seconds
  alert_rules            = var.alert_rules
}

module "contact_points" {
  source = "./modules/contact-points"

  count = length(var.alert_rules) != 0 ? 1 : 0

  slack_endpoints    = var.slack_endpoints
  opsgenie_endpoints = var.opsgenie_endpoints
}

module "notifications" {
  source = "./modules/notifications"

  count = length(var.alert_rules) != 0 ? 1 : 0

  notifications = var.notifications
}
