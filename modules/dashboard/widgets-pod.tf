# Pod widgets
module "pod_cpu_widget" {
  source = "./modules/widgets/pod/cpu"

  for_each = { for index, item in try(local.widget_config["pod/cpu"], []) : index => item }

  data_source = each.value.data_source
  coordinates = each.value.coordinates
  period      = each.value.period

  # pod
  pod       = each.value.pod
  cluster   = try(each.value.cluster, null)
  namespace = each.value.namespace
  by_pod    = try(each.value.by_pod, false)

  account_id        = each.value.account_id
  region            = each.value.region
  anomaly_detection = each.value.anomaly_detection
  anomaly_deviation = each.value.anomaly_deviation
}
