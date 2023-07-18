module "this" {
  source = "../../"

  notifications = {
    contact_point   = "Slack"
    group_by        = ["alertname"]
    group_interval  = "10m"
    repeat_interval = "1h"

    policy = {
      contact_point = "Opsgenie"
      continue      = false

      matcher = {
        label = "priority"
        match = "="
        value = "P1"
      }
    }
  }
}
