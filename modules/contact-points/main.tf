//Slack Integration
resource "grafana_contact_point" "slack_contact_point" {
  for_each = { for cp in var.slack_endpoints : cp.name => cp }

  name = each.key

  slack {
    endpoint_url            = each.value.webhook_url
    icon_emoji              = each.value.icon_emoji
    icon_url                = each.value.icon_url
    recipient               = each.value.webhook_url != null ? each.value.recipient : null
    text                    = each.value.text
    title                   = each.value.title
    token                   = each.value.webhook_url != null ? each.value.token : null
    url                     = each.value.webhook_url
    username                = each.value.username
    disable_resolve_message = each.value.disable_resolve_message
  }
}

//OpsGenie Integration
resource "grafana_contact_point" "opsgenie_contact_point" {
  for_each = { for cp in var.opsgenie_endpoints : cp.name => cp }

  name = each.key

  opsgenie {
    api_key                 = each.value.api_key
    auto_close              = each.value.auto_close
    message                 = each.value.message
    url                     = each.value.api_url
    disable_resolve_message = each.value.disable_resolve_message
  }
}
