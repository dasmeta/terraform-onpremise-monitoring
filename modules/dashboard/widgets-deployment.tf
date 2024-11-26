# Pod widgets
module "deployment_replicas_widget" {
  source = "./modules/widgets/deployment/replicas"

  for_each = { for index, item in try(local.widget_config["deployment/replicas"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  # deployment
  deployment       = each.value.deployment
  cluster   = try(each.value.cluster, null)
  namespace = each.value.namespace

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}
