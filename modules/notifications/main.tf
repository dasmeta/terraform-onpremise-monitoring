resource "grafana_notification_policy" "policy" {
  count = var.notifications.policy != null ? 1 : 0

  contact_point   = var.notifications.contact_point
  group_by        = var.notifications.group_by
  group_interval  = var.notifications.group_interval
  repeat_interval = var.notifications.repeat_interval

  dynamic "policy" {
    for_each = var.notifications.policy != null ? [1] : []

    content {
      contact_point = var.notifications.policy.contact_point
      continue      = var.notifications.policy.continue
      group_by      = var.notifications.policy.group_by
      mute_timings  = var.notifications.policy.mute_timings

      dynamic "matcher" {
        for_each = var.notifications.policy.matcher.label != null ? [1] : [0]

        content {
          label = var.notifications.policy.matcher.label
          match = var.notifications.policy.matcher.match
          value = var.notifications.policy.matcher.value
        }
      }
    }
  }
}
