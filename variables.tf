variable "alert_interval_seconds" {
  type        = number
  default     = 10
  description = "The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially."
}

variable "alert_rules" {
  type = list(object({
    name            = string                          # The name of the alert rule
    summary         = optional(string, "")            # Rule annotation as a summary
    folder_name     = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created
    datasource      = string                          # Name of the datasource used for the alert
    metric_name     = string                          # Prometheus metric name which queries the data for the alert
    metric_function = optional(string, "")            # Prometheus function used with metric for queries, like rate, sum etc.
    metric_interval = optional(string, "")            # The time interval with using functions like rate
    filters         = optional(any, {})               # Filters object to identify each service for alerting
    function        = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting
    equation        = string                          # The equation in the math expression which compares B blocks value with a number and generates an alert if needed. Possible values: gt, lt, gte, lte, e.
    threshold       = number                          # The value against which B blocks are compared in the math expression
  }))
  default     = []
  description = "This varibale describes alert folders, groups and rules."
}

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
