module "this" {
  source = "../../"

  alert_rules = [
    {
      name            = "App_1 has 0 available replicas"
      folder_name     = "Replica Count"
      datasource      = "prometheus"
      metric_name     = "kube_deployment_status_replicas_available"
      metric_function = "rate"
      metric_interval = "[5m]"
      filters = {
        deployment = "app-1-microservice"
      }
      function  = "last"
      equation  = "lt"
      threshold = 1
    },
    {
      name            = "App_2 has 0 available replicas"
      folder_name     = "Replica Count"
      datasource      = "prometheus"
      metric_name     = "kube_deployment_status_replicas_available"
      metric_function = "rate"
      metric_interval = "[5m]"
      filters = {
        deployment = "app-2-microservice"
      }
      function  = "last"
      equation  = "lt"
      threshold = 1
    }
  ]
}
