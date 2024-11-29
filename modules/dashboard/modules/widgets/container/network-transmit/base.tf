module "base" {
  source = "../../base"

  name              = "Network Transmit Errors [${var.period}m]"
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

  metrics = [
    { label : "Received Errors", color : "FF103B", expression : "rate(container_network_transmit_errors_total{pod=~\"^${var.pod}-[^-]+-[^-]+$\"}[${var.period}m])" },
  ]
}
