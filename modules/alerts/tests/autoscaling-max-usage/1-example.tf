module "this" {
  source = "../../"

  alert_rules = [
    {
      name        = "App_1 max autoscaling"
      summary     = "App_1 microservice has been using max replicas for 1 hour"
      folder_name = "Autoscaling"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-1-microservice"
      }
      function  = "mean"
      condition = "$B >= 20"
    },
    {
      name        = "App_2 max autoscaling"
      summary     = "App_2 microservice has been using max replicas for 1 hour"
      folder_name = "Autoscaling"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-2-microservice"
      }
      function  = "mean"
      condition = "$B >= 20"
    }
  ]
}
