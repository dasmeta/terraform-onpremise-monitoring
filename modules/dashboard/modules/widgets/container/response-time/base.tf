module "base" {
  source = "../../base"

  name              = "Response Time [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    MetricNamespace = "AWS/ApplicationELB"
    LoadBalancer    = var.balancer_name
    TargetGroup     = var.target_group_name
    accountId       = var.account_id
  }

  metrics = [
    { label = "Avg", expression = "avg(rate(nginx_ingress_controller_request_duration_seconds_sum{host=\"${var.host}\"}[${var.period}m])) / avg(rate(nginx_ingress_controller_request_duration_seconds_count{host=\"${var.host}\"}[${var.period}m]))" },
    { label = "Max", expression = "max(rate(nginx_ingress_controller_request_duration_seconds_sum{host=\"${var.host}\"}[${var.period}m])) / max(rate(nginx_ingress_controller_request_duration_seconds_count{host=\"${var.host}\"}[${var.period}m]))" },
    { label = "Acceptable", expression = "${var.acceptable}" },
    { label = "Problem", expression = "${var.problem}" },
  ]
}
