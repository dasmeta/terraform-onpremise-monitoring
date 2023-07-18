module "this" {
  source = "../../"

  notifications = {
    contact_point   = "Slack"
    group_by        = ["..."]
    group_interval  = "10m"
    repeat_interval = "1h"
  }
}
