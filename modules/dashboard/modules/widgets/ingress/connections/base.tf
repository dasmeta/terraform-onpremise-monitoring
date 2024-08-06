module "base" {
  source = "../../base"

  name              = "Connections (${var.ingress_type}) [${var.period}m]"
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

  metrics = [
    { label : "1m range", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[1m]))" },
    { label : "${var.period}m range", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[${var.period}m]))" },
  ]
}
