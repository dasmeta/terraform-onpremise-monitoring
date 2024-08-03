# terraform-onpremise-grafana 
https://registry.terraform.io/modules/dasmeta/grafana/onpremise/latest

This module is created to manage OnPremise Grafana stack with Terraform.
At this moment we support managing
- Grafana Dashboard with `dashboard` submodule
- Grafana Alerts with `alerts` submodule
- Grafana Contact Points with `contact-points` submodule
- Grafana Notification Policies with `notifications` submodule

More parts are coming soon.

## example for dashboard
```hcl
module "grafana_monitoring" {
  source  = "dasmeta/grafana/onpremise"
  version = "1.2.0"

  name = "Test-dashboard"

  application_dashboard = {
    rows : [
      { type : "block/sla" },
      { type : "block/ingress" },
      { type : "block/service", name : "service-name-1", host : "example.com" },
      { type : "block/service", name : "service-name-2" },
      { type : "block/service", name : "service-name-3" }
    ]
    data_source = {
      uid : "00000"
    }
    variables = [
      {
        "name" : "namespace",
        "options" : [
          {
            "selected" : true,
            "value" : "prod"
          },
          {
            "value" : "stage"
          },
          {
            "value" : "dev"
          }
        ],
      }
    ]
  }
}
```

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
Check `./tests`, `modules/alerts/tests`, `modules/contact-points/tests` and `modules/notifications/tests` folders to see more examples.
