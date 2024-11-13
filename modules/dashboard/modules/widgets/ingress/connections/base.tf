module "base" {
  source = "../../base"

  name              = "Active Connections (${var.ingress_type}) [${var.period}m]"
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
    { label : "1m", color : "D400BF", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[1m]))" },
    { label : "5m", color : "007CEF", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[5m]))" },
    { label : "15m", color : "FFC300", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[15m]))" },
    { label : "${var.period}m range", color : "7AAFF9", expression : "sum(rate(nginx_ingress_controller_nginx_process_connections[${var.period}m]))" },
  ]
}
