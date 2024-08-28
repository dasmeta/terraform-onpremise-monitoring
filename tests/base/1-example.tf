module "this" {
  source = "../.."

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

  alert_rules = [
    {
      "datasource" : "prometheus",
      "equation" : "gt",
      "expr" : "avg(increase(nginx_ingress_controller_request_duration_seconds_sum[3m])) / 10",
      "filters" : null,
      "folder_name" : "Nginx Alerts",
      "function" : "mean",
      "name" : "Latency",
      "labels" : {
        "priorityHigh" : "true",
      }
      "summary" : "Latency is higher than 3s",
      "threshold" : 3
    },
  ]

  notifications = {
    "group_interval" : "1m",
    "repeat_interval" : "1m",
    "contact_point" : "Slack",
    "policies" : [
      {
        "contact_point" : "OpsGenie",
        "continue" : "true",
        "matchers" : [{
          "label" : "priorityHigh",
          "match" : "=",
          "value" : "true"
        }]
      },
    ]
  }
}
