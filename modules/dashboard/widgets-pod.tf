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

# module "container_memory_widget" {
#   source = "./modules/widgets/container/memory"

#   for_each = { for index, item in try(local.widget_config["container/memory"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period

#   # container
#   container = each.value.container
#   cluster   = each.value.cluster
#   namespace = each.value.namespace

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }

# module "container_network_widget" {
#   source = "./modules/widgets/container/network"

#   for_each = { for index, item in try(local.widget_config["container/network"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period

#   # container
#   container = each.value.container
#   cluster   = each.value.cluster
#   namespace = each.value.namespace
#   host      = try(each.value.host, null)

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }

# module "container_replicas_widget" {
#   source = "./modules/widgets/container/replicas"

#   for_each = { for index, item in try(local.widget_config["container/replicas"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period

#   # container
#   container = each.value.container
#   cluster   = each.value.cluster
#   namespace = each.value.namespace

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }

# module "container_restarts_widget" {
#   source = "./modules/widgets/container/restarts"

#   for_each = { for index, item in try(local.widget_config["container/restarts"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period

#   # container
#   container = each.value.container
#   cluster   = each.value.cluster
#   namespace = each.value.namespace

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }

# module "container_request_count_widget" {
#   source = "./modules/widgets/container/request-count"

#   for_each = { for index, item in try(local.widget_config["container/request-count"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period

#   # container
#   host              = each.value.host
#   target_group_name = try(each.value.target_group_name, null)
#   only_5xx          = try(each.value.only_5xx, false)

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }

# module "container_response_time_widget" {
#   source = "./modules/widgets/container/response-time"

#   for_each = { for index, item in try(local.widget_config["container/response-time"], []) : index => item }

#   data_source = each.value.data_source
#   coordinates = each.value.coordinates
#   period      = each.value.period
#   acceptable  = try(each.value.acceptable, 1)
#   problem     = try(each.value.problem, 2)

#   # container
#   host              = each.value.host
#   balancer_name     = try(each.value.balancer_name, null)
#   target_group_name = try(each.value.target_group_name, null)

#   account_id        = each.value.account_id
#   region            = each.value.region
#   anomaly_detection = each.value.anomaly_detection
#   anomaly_deviation = each.value.anomaly_deviation
# }
