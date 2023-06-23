## Usage
To enable some of these alerts for your applications, you just need to replace  `App_1`, `App_2` and `App_3` with the actual names of your applications. You can refer to the Prometheus metrics to identify the available filters that can be used for each application. Additionally, modify the values in the conditions to reflect the real cases of your applications. These adjustments will ensure that the alerts accurately monitor your specific applications and their scaling needs.
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
| [grafana_folder.rule_folder](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder) | resource |
| [grafana_rule_group.alert_rule](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_interval_seconds"></a> [alert\_interval\_seconds](#input\_alert\_interval\_seconds) | The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially. | `number` | `10` | no |
| <a name="input_alert_rules"></a> [alert\_rules](#input\_alert\_rules) | This varibale describes alert folders, groups and rules. | <pre>list(object({<br>    name        = string                          # The name of the alert rule<br>    summary     = optional(string, "")            # Rule annotation as a summary<br>    folder_name = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created<br>    datasource  = string                          # Name of the datasource used for the alert<br>    metric_name = string                          # Prometheus metric name which queries the data for the alert<br>    filters     = optional(any, {})               # Filters object to identify each service for alerting<br>    function    = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting<br>    condition   = string                          # Math expression which compares B blocks value with a number and generates an alert if needed<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
