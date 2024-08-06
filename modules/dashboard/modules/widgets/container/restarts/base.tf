module "base" {
  source = "../../base"

  name              = "Restarts [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  stat              = "Maximum"
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    MetricNamespace = "ContainerInsights"
    ClusterName     = var.cluster
    Namespace       = var.namespace
    PodName         = var.container
    accountId       = var.account_id
  }

  metrics = [
    { label = "Restarts", expression = "sum(rate(kube_pod_container_status_restarts_total{container=\"${var.container}\", namespace=\"${var.namespace}\"}[${var.period}m])) by (container)" },
  ]
}
