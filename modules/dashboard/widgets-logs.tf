# Logs widgets
module "logs_count_widget" {
  source = "./modules/widgets/logs/count"

  for_each = { for index, item in try(local.widget_config["logs/count"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  aggregated_metric = each.value.aggregated_metric

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}

module "logs_error_rate_widget" {
  source = "./modules/widgets/logs/error-rate"

  for_each = { for index, item in try(local.widget_config["logs/error-rate"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  aggregated_metric = each.value.aggregated_metric

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}

module "logs_warning_rate_widget" {
  source = "./modules/widgets/logs/warning-rate"

  for_each = { for index, item in try(local.widget_config["logs/warning-rate"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  aggregated_metric = each.value.aggregated_metric

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}
