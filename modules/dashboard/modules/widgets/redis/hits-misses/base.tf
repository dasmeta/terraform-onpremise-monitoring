module "base" {
  source = "../../base"

  name              = "Hits / Misses per Sec [${var.period}m]"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  metrics = [
    { label = "Hits", color : "007cef", expression = "irate(redis_keyspace_hits_total{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}[${var.period}m])" },
    { label = "Misses", color : "d400bf", expression = "irate(redis_keyspace_misses_total{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}[${var.period}m])" }
  ]
}
