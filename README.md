# terraform-onpremise-monitoring
This module is created to manage OnPremise Monitoring stack with Terraform. At this moment we support managing Grafana Alerts with `alerts` submodule but more parts are on their way.

## Example
```
module "this" {
  source = "dasmeta/onpremise/grafana"

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
      condition = "$B < 1"
    },
    {
      name        = "App_2 has 0 available replicas"
      folder_name = "Replica Count"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-2-microservice"
      }
      function  = "last"
      condition = "$B < 1"
    }
  ]
}
```

## Usage
Check `modules/alerts/tests` folder to see more examples.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alerts"></a> [alerts](#module\_alerts) | ./modules/alerts | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_rules"></a> [alert\_rules](#input\_alert\_rules) | This varibale describes alert folders, groups and rules. | <pre>list(object({<br>    name        = string                          # The name of the alert rule<br>    summary     = optional(string, "")            # Rule annotation as a summary<br>    folder_name = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created<br>    datasource  = string                          # Name of the datasource used for the alert<br>    metric_name = string                          # Prometheus metric name which queries the data for the alert<br>    filters     = optional(any, {})               # Filters object to identify each service for alerting<br>    function    = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting<br>    condition   = string                          # Math expression which compares B blocks value with a number and generates an alert if needed<br>  }))</pre> | `[]` | no |
| <a name="input_interval_seconds"></a> [interval\_seconds](#input\_interval\_seconds) | The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially. | `number` | `10` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
