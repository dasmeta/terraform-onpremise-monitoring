module "base" {
  source = "../../base"

  name              = "Memory"
  data_source       = var.data_source
  coordinates       = var.coordinates
  period            = var.period
  region            = var.region
  anomaly_detection = var.anomaly_detection
  anomaly_deviation = var.anomaly_deviation

  defaults = {
    MetricNamespace = "ContainerInsights"
    ClusterName     = var.cluster
    Namespace       = var.namespace
    PodName         = var.pod
    accountId       = var.account_id
  }

  metrics = [
    { label = "AVG", expression = "avg(container_memory_usage_bytes{container=\"${var.container}\", namespace=\"${var.namespace}\"}) by (container) / 1024 / 1024" },
    { label = "Request", expression = "avg(kube_pod_container_resource_requests{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"memory\"}) / 1024 / 1024" },
    { label = "Limit", expression = "avg(kube_pod_container_resource_limits{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"memory\"}) / 1024 / 1024" },
    { label = "MAX", expression = "max(container_memory_usage_bytes{container=\"${var.container}\", namespace=\"${var.namespace}\"}) by (container) / 1024 / 1024" },
  ]
}
