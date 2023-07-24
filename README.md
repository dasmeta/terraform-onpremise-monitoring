# terraform-onpremise-grafana
This module is created to manage OnPremise Grafana stack with Terraform.
At this moment we support managing
- Grafana Alerts with `alerts` submodule
- Grafana Contact Points with `contact-points` submodule
- Grafana Notification Policies with `notifications` submodule

More parts are coming soon.

## Example for Alert Rules
```
module "grafana_alerts" {
  source  = "dasmeta/grafana/onpremise//modules/alerts"
  version = "1.0.0"

  alert_rules = [
    {
      name        = "App_1 has 0 available replicas"
      folder_name = "Replica Count"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-1-microservice"
      }
      function  = "last"
      equation = "lt"
      threshold = 1
    },
    {
      name        = "Nginx Expressions"
      folder_name = "Nginx Expressions Group"
      datasource  = "prometheus"
      expr        = "sum(rate(nginx_ingress_controller_requests{status=~'5..'}[1m])) by (ingress,cluster) / sum(rate(nginx_ingress_controller_requests[1m]))by (ingress) * 100 > 5"
      function    = "mean"
      equation    = "gt"
      threshold   = 2
    },
  ]
}
```

## Example for Contact Points
```
module "grafana_contact_points" {
  source  = "dasmeta/grafana/onpremise//modules/contact-points"

  opsgenie_endpoints = [
    {
      name       = "Dev OpsGenie"
      api_key    = "asdARdszgads1235fsdad"
      auto_close = true
    },
    {
      name    = "Stage OpsGenie"
      api_key = "werARdsswefazgads12dad"
    }
  ]
  slack_endpoints = [
    {
      name        = "Dev Notifications"
      webhook_url = "https://hooks.slack.com/services/T6safsfFSF2352SFzdn"
    }
  ]
}
```

## Example for Notifications
```
module "grafana_contact_points" {
  source  = "dasmeta/grafana/onpremise//modules/notifications"

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
```

## Example for all submodules together
```
module "grafana_alerts" {
  source  = "dasmeta/grafana/onpremise"

  alert_rules = [
    {
      name        = "App_1 has 0 available replicas"
      folder_name = "Test"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-1-microservice"
      }
      function  = "last"
      equation = "lt"
      threshold = 1
    },
    {
      name        = "App_2 has 0 available replicas"
      folder_name = "Test"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-2-microservice"
      }
      function  = "last"
      equation = "lt"
      threshold = 1
    }
  ]

  opsgenie_endpoints = [
    {
      name       = "Dev OpsGenie"
      api_key    = "asdARdszgads1235fsdad"
      auto_close = true
    },
    {
      name    = "Stage OpsGenie"
      api_key = "werARdsswefazgads12dad"
    }
  ]

  slack_endpoints = [
    {
      name        = "Dev Notifications"
      webhook_url = "https://hooks.slack.com/services/T6safsfFSF2352SFzdn"
    }
  ]

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
```

## Usage
Check `modules/alerts/tests`, `modules/contact-points/tests` and `modules/notifications/tests` folders to see more examples.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alerts"></a> [alerts](#module\_alerts) | ./modules/alerts | n/a |
| <a name="module_contact_points"></a> [contact\_points](#module\_contact\_points) | ./modules/contact-points | n/a |
| <a name="module_notifications"></a> [notifications](#module\_notifications) | ./modules/notifications | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_interval_seconds"></a> [alert\_interval\_seconds](#input\_alert\_interval\_seconds) | The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially. | `number` | `10` | no |
| <a name="input_alert_rules"></a> [alert\_rules](#input\_alert\_rules) | This varibale describes alert folders, groups and rules. | <pre>list(object({<br>    name            = string                          # The name of the alert rule<br>    summary         = optional(string, "")            # Rule annotation as a summary<br>    priority        = optional(string, "P2")          # Rule priority level: P2 is for non-critical alerts, P1 will be set for critical alerts<br>    folder_name     = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created<br>    datasource      = string                          # Name of the datasource used for the alert<br>    metric_name     = string                          # Prometheus metric name which queries the data for the alert<br>    metric_function = optional(string, "")            # Prometheus function used with metric for queries, like rate, sum etc.<br>    metric_interval = optional(string, "")            # The time interval with using functions like rate<br>    filters         = optional(any, {})               # Filters object to identify each service for alerting<br>    function        = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting<br>    equation        = string                          # The equation in the math expression which compares B blocks value with a number and generates an alert if needed. Possible values: gt, lt, gte, lte, e.<br>    threshold       = number                          # The value against which B blocks are compared in the math expression<br>  }))</pre> | `[]` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | Represents the configuration options for Grafana notification policies. | <pre>object({<br>    contact_point   = optional(string, "Slack")                               # The default contact point to route all unmatched notifications to.<br>    group_by        = optional(list(string), ["grafana_folder", "alertname"]) # A list of alert labels to group alerts into notifications by.<br>    group_interval  = optional(string, "5m")                                  # Minimum time interval between two notifications for the same group.<br>    repeat_interval = optional(string, "4h")                                  # Minimum time interval for re-sending a notification if an alert is still firing.<br><br>    policy = optional(object({<br>      contact_point = optional(string, null) # The contact point to route notifications that match this rule to.<br>      continue      = optional(bool, false)  # Whether to continue matching subsequent rules if an alert matches the current rule. Otherwise, the rule will be 'consumed' by the first policy to match it.<br>      group_by      = optional(list(string), [])<br>      mute_timings  = optional(list(string), []) # A list of mute timing names to apply to alerts that match this policy.<br><br>      matcher = optional(object({<br>        label = optional(string, "priority") # The name of the label to match against.<br>        match = optional(string, "=")        # The operator to apply when matching values of the given label. Allowed operators are = for equality, != for negated equality, =~ for regex equality, and !~ for negated regex equality.<br>        value = optional(string, "P1")       # The label value to match against.<br>      }))<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_opsgenie_endpoints"></a> [opsgenie\_endpoints](#input\_opsgenie\_endpoints) | OpsGenie contact points list. | <pre>list(object({<br>    name                    = string                                                 # The name of the contact point.<br>    api_key                 = string                                                 # The OpsGenie API key to use.<br>    auto_close              = optional(bool, false)                                  # Whether to auto-close alerts in OpsGenie when they resolve in the Alertmanager.<br>    message                 = optional(string, "")                                   # The templated content of the message.<br>    api_url                 = optional(string, "https://api.opsgenie.com/v2/alerts") # Allows customization of the OpsGenie API URL.<br>    disable_resolve_message = optional(bool, false)                                  # Whether to disable sending resolve messages.<br>  }))</pre> | `[]` | no |
| <a name="input_slack_endpoints"></a> [slack\_endpoints](#input\_slack\_endpoints) | Slack contact points list. | <pre>list(object({<br>    name                    = string                                                     # The name of the contact point.<br>    endpoint_url            = optional(string, "https://slack.com/api/chat.postMessage") # Use this to override the Slack API endpoint URL to send requests to.<br>    icon_emoji              = optional(string, "")                                       # The name of a Slack workspace emoji to use as the bot icon.<br>    icon_url                = optional(string, "")                                       # A URL of an image to use as the bot icon.<br>    recipient               = optional(string, null)                                     # Channel, private group, or IM channel (can be an encoded ID or a name) to send messages to.<br>    text                    = optional(string, "")                                       # Templated content of the message.<br>    title                   = optional(string, "")                                       # Templated title of the message.<br>    token                   = optional(string, "")                                       # A Slack API token,for sending messages directly without the webhook method.<br>    webhook_url             = optional(string, "")                                       # A Slack webhook URL,for sending messages via the webhook method.<br>    username                = optional(string, "")                                       # Username for the bot to use.<br>    disable_resolve_message = optional(bool, false)                                      # Whether to disable sending resolve messages.<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
