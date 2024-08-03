module "base" {
  source = "../../base"

  name              = "Response time (${var.ingress_type})${var.by_host ? " by host" : ""} [${var.period}m]"
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

  metrics = var.by_host ? [
    { label : "__auto", expression : "avg(increase(nginx_ingress_controller_request_duration_seconds_sum[${var.period}m])) by (host) * 100" },
    { label : "__auto", expression : "max(increase(nginx_ingress_controller_request_duration_seconds_sum[${var.period}m])) by (host)" },
    ] : [
    { label = "Avg", expression = "avg(rate(nginx_ingress_controller_request_duration_seconds_sum[${var.period}m])) / avg(rate(nginx_ingress_controller_request_duration_seconds_count[${var.period}m]))" },
    { label = "Max", expression = "max(rate(nginx_ingress_controller_request_duration_seconds_sum[${var.period}m])) / max(rate(nginx_ingress_controller_request_duration_seconds_count[${var.period}m]))" },
    { label = "Acceptable", expression = "${var.acceptable}" },
    { label = "Problem", expression = "${var.problem}" },
  ]
}
