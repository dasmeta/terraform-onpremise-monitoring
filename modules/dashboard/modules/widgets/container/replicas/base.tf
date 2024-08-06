module "base" {
  source = "../../base"

  name              = "Replicas"
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
    accountId       = var.account_id
  }

  metrics = [
    { label = "Total", expression = "sum(kube_pod_status_phase{namespace=\"${var.namespace}\", pod=~\"${var.container}-.*\"})" },
    { label = "Running", expression = "sum(kube_pod_container_status_running{namespace=\"${var.namespace}\", pod=~\"${var.container}-.*\"})" },
    { label = "Terminated", expression = "sum(kube_pod_container_status_terminated{namespace=\"${var.namespace}\", pod=~\"${var.container}-.*\"})" },
    { label = "Waiting", expression = "sum(kube_pod_container_status_waiting{namespace=\"${var.namespace}\", pod=~\"${var.container}-.*\"})" },
  ]
}
