## Usage
This Terraform module helps you manage Grafana notification policies, making it easier to configure alert notifications for different contact points and conditions.

Notification policies can be created for various contact points. Additionally, you can have nested policies.

Please refer to the `tests` folder for real examples.
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
| [grafana_notification_policy.policy](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/notification_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_notifications"></a> [notifications](#input\_notifications) | Represents the configuration options for Grafana notification policies. | <pre>object({<br>    contact_point   = optional(string, "Slack")       # The default contact point to route all unmatched notifications to.<br>    group_by        = optional(list(string), ["..."]) # A list of alert labels to group alerts into notifications by.<br>    group_interval  = optional(string, "5m")          # Minimum time interval between two notifications for the same group.<br>    repeat_interval = optional(string, "4h")          # Minimum time interval for re-sending a notification if an alert is still firing.<br><br>    policies = optional(list(object({<br>      contact_point = optional(string, null) # The contact point to route notifications that match this rule to.<br>      continue      = optional(bool, false)  # Whether to continue matching subsequent rules if an alert matches the current rule. Otherwise, the rule will be 'consumed' by the first policy to match it.<br>      group_by      = optional(list(string), ["..."])<br>      mute_timings  = optional(list(string), []) # A list of mute timing names to apply to alerts that match this policy.<br><br>      matchers = optional(list(object({<br>        label = optional(string, "priority") # The name of the label to match against.<br>        match = optional(string, "=")        # The operator to apply when matching values of the given label. Allowed operators are = for equality, != for negated equality, =~ for regex equality, and !~ for negated regex equality.<br>        value = optional(string, "P1")       # The label value to match against.<br>      })), [])<br>    })), [])<br>  })</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
