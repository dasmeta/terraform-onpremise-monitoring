module "base" {
  source = "../../base"

  name              = "Memory (${var.ingress_type}) [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    MetricNamespace = "ContainerInsights"
    accountId       = var.account_id
  }

  options = {
    legend = {
      show_legend = false
    }
  }

  unit = "bytes"

  metrics = [
    { label : "__auto", expression : "container_memory_working_set_bytes{pod=~\"${var.pod}-[^-]+-[^-]+$\", namespace=\"${var.namespace}\"}" },
  ]
}
