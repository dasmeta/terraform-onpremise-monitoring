module "base" {
  source = "../../base"

  name              = "Max Uptime [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  unit = "s"
  view = "stat"

  metrics = [
    { label = "Uptime", color : "808080", expression = "max(max_over_time(redis_uptime_in_seconds{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}[${var.period}m]))" }
  ]
}
