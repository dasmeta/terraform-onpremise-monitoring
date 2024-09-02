module "alert_rules" {
  source = "../alert-rules"

  count = var.rules != null ? 1 : 0

  alert_interval_seconds = var.alert_interval_seconds
  disable_provenance     = var.disable_provenance
  alert_rules            = var.rules
}

module "contact_points" {
  source = "../alert-contact-points"

  count = var.contact_points != null ? 1 : 0

  disable_provenance = var.disable_provenance
  slack_endpoints    = var.contact_points.slack
  opsgenie_endpoints = var.contact_points.opsgenie
  webhook_endpoints  = var.contact_points.webhook
}

module "notifications" {
  source = "../alert-notifications"

  count = var.notifications != null ? 1 : 0

  disable_provenance = var.disable_provenance
  notifications      = var.notifications

  depends_on = [module.contact_points]
}
