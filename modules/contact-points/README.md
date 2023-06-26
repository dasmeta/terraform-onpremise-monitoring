## Usage
This Terraform module enables the creation of Grafana contact points for various integrations such as Slack and OpsGenie. Contact points allow you to configure alert notifications to different services based on your requirements.

There are numerous integrations available for Grafana, but currently, this module supports only Slack and OpsGenie. We are continuously working to add more integrations in the future. If you have any questions or need assistance, feel free to open an issue or contact our team.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 1.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | >= 1.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_contact_point.opsgenie_contact_point](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/contact_point) | resource |
| [grafana_contact_point.slack_contact_point](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/contact_point) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_opsgenie_endpoints"></a> [opsgenie\_endpoints](#input\_opsgenie\_endpoints) | OpsGenie contact points list. | <pre>list(object({<br>    name                    = string                                                 # The name of the contact point.<br>    api_key                 = string                                                 # The OpsGenie API key to use.<br>    auto_close              = optional(bool, false)                                  # Whether to auto-close alerts in OpsGenie when they resolve in the Alertmanager.<br>    message                 = optional(string, "")                                   # The templated content of the message.<br>    api_url                 = optional(string, "https://api.opsgenie.com/v2/alerts") # Allows customization of the OpsGenie API URL.<br>    disable_resolve_message = optional(bool, false)                                  # Whether to disable sending resolve messages.<br>  }))</pre> | `[]` | no |
| <a name="input_slack_endpoints"></a> [slack\_endpoints](#input\_slack\_endpoints) | Slack contact points list. | <pre>list(object({<br>    name                    = string                                                     # The name of the contact point.<br>    endpoint_url            = optional(string, "https://slack.com/api/chat.postMessage") # Use this to override the Slack API endpoint URL to send requests to.<br>    icon_emoji              = optional(string, "")                                       # The name of a Slack workspace emoji to use as the bot icon.<br>    icon_url                = optional(string, "")                                       # A URL of an image to use as the bot icon.<br>    recipient               = optional(string, null)                                     # Channel, private group, or IM channel (can be an encoded ID or a name) to send messages to.<br>    text                    = optional(string, "")                                       # Templated content of the message.<br>    title                   = optional(string, "")                                       # Templated title of the message.<br>    token                   = optional(string, "")                                       # A Slack API token,for sending messages directly without the webhook method.<br>    webhook_url             = optional(string, "")                                       # A Slack webhook URL,for sending messages via the webhook method.<br>    username                = optional(string, "")                                       # Username for the bot to use.<br>    disable_resolve_message = optional(bool, false)                                      # Whether to disable sending resolve messages.<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
