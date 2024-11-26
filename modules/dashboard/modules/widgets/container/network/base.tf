module "base" {
  source = "../../base"

  name              = "Network Traffic"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation
  unit              = "bytes"

  defaults = {
    MetricNamespace = "ContainerInsights"
    ClusterName     = var.cluster
    Namespace       = var.namespace
    PodName         = var.container
    accountId       = var.account_id
  }


  metrics = [
    { label = "RECEIVED", expression = "sum(rate(container_network_receive_bytes_total{namespace=\"${var.namespace}\", pod=~\"^${var.container}-[^-]+-[^-]+$\"}[$__rate_interval]))" },
    { label = "SENT", color = "FF0F3C", expression = "- sum(rate(container_network_transmit_bytes_total{namespace=\"${var.namespace}\", pod=~\"^${var.container}-[^-]+-[^-]+$\"}[$__rate_interval]))" },
  ]  
}
