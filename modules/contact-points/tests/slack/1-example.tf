module "this" {
  source = "../../"

  slack_endpoints = [
    {
      name        = "Dev Notifications"
      webhook_url = "https://hooks.slack.com/services/T6safsfFSF2352SFzdn"
    },
    {
      name      = "Prod Notifications"
      recipient = "prod-channel"
      token     = "xxxxxxxxx"
    }
  ]
}
