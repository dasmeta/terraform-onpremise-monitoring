variable "slack_endpoints" {
  type = list(object({
    name                    = string                                                     # The name of the contact point.
    endpoint_url            = optional(string, "https://slack.com/api/chat.postMessage") # Use this to override the Slack API endpoint URL to send requests to.
    icon_emoji              = optional(string, "")                                       # The name of a Slack workspace emoji to use as the bot icon.
    icon_url                = optional(string, "")                                       # A URL of an image to use as the bot icon.
    recipient               = optional(string, null)                                     # Channel, private group, or IM channel (can be an encoded ID or a name) to send messages to.
    text                    = optional(string, "")                                       # Templated content of the message.
    title                   = optional(string, "")                                       # Templated title of the message.
    token                   = optional(string, "")                                       # A Slack API token,for sending messages directly without the webhook method.
    webhook_url             = optional(string, "")                                       # A Slack webhook URL,for sending messages via the webhook method.
    username                = optional(string, "")                                       # Username for the bot to use.
    disable_resolve_message = optional(bool, false)                                      # Whether to disable sending resolve messages.
  }))
  default     = []
  description = "Slack contact points list."
}

variable "opsgenie_endpoints" {
  type = list(object({
    name                    = string                                                 # The name of the contact point.
    api_key                 = string                                                 # The OpsGenie API key to use.
    auto_close              = optional(bool, false)                                  # Whether to auto-close alerts in OpsGenie when they resolve in the Alertmanager.
    message                 = optional(string, "")                                   # The templated content of the message.
    api_url                 = optional(string, "https://api.opsgenie.com/v2/alerts") # Allows customization of the OpsGenie API URL.
    disable_resolve_message = optional(bool, false)                                  # Whether to disable sending resolve messages.
  }))
  default     = []
  description = "OpsGenie contact points list."
}
