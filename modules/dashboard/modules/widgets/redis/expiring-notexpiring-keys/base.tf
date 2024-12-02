module "base" {
  source = "../../base"

  name              = "Expiring / Not-Expiring Keys"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  metrics = [
    { label = "Not Expiring", color : "3ece76", expression = "sum (redis_db_keys{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}) by (instance) - sum (redis_db_keys_expiring{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}) by (instance)" },
    { label = "Expiring", color : "ff0f3c", expression = "sum (redis_db_keys_expiring{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}) by (instance)" },
  ]
}
