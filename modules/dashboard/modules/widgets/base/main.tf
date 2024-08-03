module "base_grafana" {
  source = "./platforms/grafana"

  name              = var.name
  data_source       = var.data_source
  coordinates       = var.coordinates
  metrics           = var.metrics
  defaults          = var.defaults
  stat              = var.stat
  period            = var.period
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation
  type              = var.type
  query             = var.query
  sources           = var.sources
  view              = var.view
  stacked           = var.stacked
  annotations       = var.annotations
  alarms            = var.alarms
  properties_type   = var.properties_type
  decimals          = var.decimals
  fillOpacity       = var.fillOpacity
}
