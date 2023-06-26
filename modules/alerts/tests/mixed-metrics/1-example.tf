module "this" {
  source = "../../"

  alert_rules = [
    {
      name        = "App_1 has too many restarts"
      summary     = "App_1 microservice has too many restarts"
      folder_name = "Restarts"
      datasource  = "prometheus"
      metric_name = "kube_pod_container_status_restarts_total"
      filters = {
        container = "app-1-container"
      }
      function  = "mean"
      condition = "$B > 2"
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
    },
    {
      name        = "App_1 has 0 available replicas"
      folder_name = "Replica Count"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-1-microservice"
      }
      function  = "mean"
      condition = "$B < 1"
    },
    {
      name        = "App_3 has 0 available replicas"
      folder_name = "Replica Count"
      datasource  = "prometheus"
      metric_name = "kube_deployment_status_replicas_available"
      filters = {
        deployment = "app-3-microservice"
      }
      function  = "mean"
      condition = "$B < 1"
    },
    {
      name        = "Maximum node utilization in cluster"
      summary     = "Cluster is using 8 available nodes"
      folder_name = "Node Autoscaling"
      datasource  = "prometheus"
      filters     = null
      metric_name = "sum(kube_node_info)"
      function    = "mean"
      condition   = "$B >= 8"
    }
  ]
}
