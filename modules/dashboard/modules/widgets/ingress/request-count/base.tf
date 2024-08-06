module "base" {
  source = "../../base"

  name              = "Request count ${var.only_5xx ? "5XX" : "All"} (${var.ingress_type})${var.by_host ? " by host" : ""} [${var.period}m]"
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

  metrics = concat(var.only_5xx ? [] : [
    { label = var.by_host ? "{{host}}/Total" : "Total", expression = "sum(rate(nginx_ingress_controller_requests[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/2xx" : "2xx", expression = "sum(rate(nginx_ingress_controller_requests{status=~\"2..\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/3xx" : "3xx", expression = "sum(rate(nginx_ingress_controller_requests{status=~\"3..\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/4xx" : "4xx", expression = "sum(rate(nginx_ingress_controller_requests{status=~\"4..\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    ], [
    { label = var.by_host ? "{{host}}/499" : "499", expression = "sum(rate(nginx_ingress_controller_requests{status=\"499\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/5XX" : "5XX", expression = "sum(rate(nginx_ingress_controller_requests{status=~\"5..\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/500" : "500", expression = "sum(rate(nginx_ingress_controller_requests{status=\"500\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/502" : "502", expression = "sum(rate(nginx_ingress_controller_requests{status=\"502\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
    { label = var.by_host ? "{{host}}/503" : "503", expression = "sum(rate(nginx_ingress_controller_requests{status=\"503\"}[${var.period}m]))${var.by_host ? " by (host)" : ""}" },
  ])
}
