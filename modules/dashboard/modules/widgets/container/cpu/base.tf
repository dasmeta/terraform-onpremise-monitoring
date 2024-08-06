module "base" {
  source = "../../base"

  name              = "CPU [${var.period}m]"
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
    PodName         = var.container
  }

  metrics = var.by_pod ? [
    { label = "__auto", expression = "avg(rate(container_cpu_usage_seconds_total{container=\"${var.container}\", namespace=\"${var.namespace}\"}[${var.period}m])) by (pod)" },
    { label = "__auto", expression = "max(rate(container_cpu_usage_seconds_total{container=\"${var.container}\", namespace=\"${var.namespace}\"}[${var.period}m])) by (pod)" },
    { label = "Request", expression = "avg(kube_pod_container_resource_requests{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"cpu\"})" },
    { label = "Limit", expression = "avg(kube_pod_container_resource_limits{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"cpu\"})" },
    ] : [
    { label = "AVG", expression = "avg(rate(container_cpu_usage_seconds_total{container=\"${var.container}\", namespace=\"${var.namespace}\"}[${var.period}m])) by (container)" },
    { label = "Request", expression = "avg(kube_pod_container_resource_requests{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"cpu\"})" },
    { label = "Limit", expression = "avg(kube_pod_container_resource_limits{container=\"${var.container}\", namespace=\"${var.namespace}\", resource=\"cpu\"})" },
    { label = "MAX", expression = "max(rate(container_cpu_usage_seconds_total{container=\"${var.container}\", namespace=\"${var.namespace}\"}[${var.period}m])) by (container)" },
  ]
}
