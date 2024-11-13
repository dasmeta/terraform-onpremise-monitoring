module "base" {
  source = "../../base"

  name              = "CPU (${var.ingress_type}) [${var.period}m]"
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

  unit = "percent"

  metrics = [
    { label : "__auto", expression : "rate(container_cpu_usage_seconds_total{pod=~\"${var.pod}-[^-]+-[^-]+$\", namespace=\"${var.namespace}\"}[$__rate_interval]) * 100" },
  ]
}
