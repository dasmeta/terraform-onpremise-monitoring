module "base" {
  source = "../../base"

  name              = "Restarts [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    MetricNamespace = "ContainerInsights"
    ClusterName     = var.cluster
    Namespace       = var.namespace
    PodName         = var.pod
    accountId       = var.account_id
  }

  metrics = [
    { label = "Restarts", color = "FF0F3C", expression = "sum(rate(kube_pod_container_status_restarts_total{pod=~\"^${var.pod}-[^-]+-[^-]+$\"}[${var.period}m]))" },
  ]
}
