module "base" {
  source = "../../base"

  name              = "Keys by DB (k)"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  metrics = [
    { label = "__auto", expression = "sum(redis_db_keys{service=\"${var.redis_name}\", namespace=\"${var.namespace}\"}) by (db) / 1000" },
  ]
}
