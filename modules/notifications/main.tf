resource "grafana_notification_policy" "policy" {
  contact_point   = var.notifications.contact_point
  group_by        = var.notifications.group_by
  group_interval  = var.notifications.group_interval
  repeat_interval = var.notifications.repeat_interval

  dynamic "policy" {
    for_each = var.notifications.policies

    content {
      contact_point = policy.value.contact_point
      continue      = policy.value.continue
      group_by      = policy.value.group_by
      mute_timings  = policy.value.mute_timings

      dynamic "matcher" {
        for_each = policy.value.matchers

        content {
          label = matcher.value.label
          match = matcher.value.match
          value = matcher.value.value
        }
      }
    }
  }
}
