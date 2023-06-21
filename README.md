# terraform-onpremise-grafana
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
