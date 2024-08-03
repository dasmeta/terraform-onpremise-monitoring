module "base" {
  source = "../base"

  name              = var.title
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  stat              = var.stat
  yAxis             = var.yAxis
  view              = var.view
  decimals          = var.decimals
  fillOpacity       = var.fillOpacity
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    accountId         = var.account_id
    anomaly_detection = var.anomaly_detection
    anomaly_deviation = var.anomaly_deviation
  }

  metrics     = var.metrics
  expressions = var.expressions
}
