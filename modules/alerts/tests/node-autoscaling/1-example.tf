module "this" {
  source = "../../"

  alert_rules = [
    {
      name        = "Maximum node utilization in cluster"
      summary     = "Cluster is using 8 available nodes"
      folder_name = "Node Autoscaling"
      datasource  = "prometheus"
      filters     = null
      metric_name = "sum(kube_node_info)"
      function    = "mean"
      equation    = "gt"
      threshold   = "8"
    },
    {
      name        = "High node utilization in cluster"
      summary     = "Cluster is using 6 of the available 8 nodes"
      folder_name = "Node Autoscaling"
      datasource  = "prometheus"
      filters     = null
      metric_name = "sum(kube_node_info)"
      function    = "mean"
      equation    = "gt"
      threshold   = "6"
    },
    {
      name        = "Insufficient nodes in cluster"
      summary     = "Cluster is using fewer nodes than the required count"
      folder_name = "Node Autoscaling"
      datasource  = "prometheus"
      filters     = null
      metric_name = "sum(kube_node_info)"
      function    = "mean"
      equation    = "lt"
      threshold   = "2"
    }
  ]
}
