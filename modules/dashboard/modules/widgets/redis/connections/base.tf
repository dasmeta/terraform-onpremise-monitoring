module "base" {
  source = "../../base"

  name              = "Connections"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  metrics = [
    { label = "Connected", color : "3ece76", expression = "sum(redis_connected_clients{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"})" },
    { label = "Blocked", color : "ff0f3c", expression = "sum(redis_blocked_clients{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"})" }
  ]
}
