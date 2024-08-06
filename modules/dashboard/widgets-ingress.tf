# Ingress widgets

module "ingress_connections_widget" {
  source = "./modules/widgets/ingress/connections"

  for_each = { for index, item in try(local.widget_config["ingress/connections"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}

module "ingress_request_rate_widget" {
  source = "./modules/widgets/ingress/request-rate"

  for_each = { for index, item in try(local.widget_config["ingress/request-rate"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period
  by_host     = try(each.value.by_host, false)

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}

module "ingress_request_count_widget" {
  source = "./modules/widgets/ingress/request-count"

  for_each = { for index, item in try(local.widget_config["ingress/request-count"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period
  by_host     = try(each.value.by_host, false)
  only_5xx    = try(each.value.only_5xx, false)

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}

module "ingress_response_time_widget" {
  source = "./modules/widgets/ingress/response-time"

  for_each = { for index, item in try(local.widget_config["ingress/response-time"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period
  by_host     = try(each.value.by_host, false)
  acceptable  = try(each.value.acceptable, 1)
  problem     = try(each.value.problem, 2)

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}
