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

  alerts = {
    rules = [
      {
        "datasource" : "prometheus",
        "equation" : "gt",
        "expr" : "avg(increase(nginx_ingress_controller_request_duration_seconds_sum[3m])) / 10",
        "folder_name" : "Nginx Alerts",
        "function" : "mean",
        "name" : "Latency P1",
        "labels" : {
          "priority" : "P1",
        }
        "threshold" : 3

        # we override no-data/exec-error state for this example/test only, it is supposed this values will not be set here so they get their default ones
        "no_data_state" : "OK"
        "exec_err_state" : "OK"
        # "exec_err_state" : "Alerting" # uncomment to trigger new alert
      },
      {
        "datasource" : "prometheus",
        "equation" : "gt",
        "expr" : "avg(increase(nginx_ingress_controller_request_duration_seconds_sum[3m])) / 10",
        "folder_name" : "Nginx Alerts",
        "function" : "mean",
        "name" : "Latency P2",
        "labels" : {
          "priority" : "P2",
        }
        "threshold" : 3

        # we override no-data/exec-error state for this example/test only, it is supposed this values will not be set here so they get their default ones
        "no_data_state" : "OK"
        "exec_err_state" : "OK"
        # "exec_err_state" : "Alerting" # uncomment to trigger new alert
      }
    ]
    contact_points = {
      webhook = [
        {
          name = "webhook-contact-point-default"
          url  = "https://example.com?default"
        },
        {
          name = "webhook-contact-point-second"
          url  = "https://example.com?second"
        },
        {
          name = "webhook-contact-point-third"
          url  = "https://example.com?third"
        }
      ]
    }
    notifications = {
      "group_interval" : "1m",
      "repeat_interval" : "1m",
      "contact_point" : "webhook-contact-point-default", # the default policy/channel will be used if no one from policies listing handled alert, in this case as third policy have no matcher rules we will not have such cases
      "policies" : [
        {
          "contact_point" : "webhook-contact-point-second", # the priority=P1 alerts will go by this channel
          "matchers" : [{
            "label" : "priority",
            "match" : "=",
            "value" : "P1"
          }]
        },
        {
          "contact_point" : "webhook-contact-point-third", # all alerts will go by this policy/channel
        },
      ]
    }
  }
}
