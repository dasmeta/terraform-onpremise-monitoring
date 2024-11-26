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
    MetricNamespace = "KubeStateMetrics"
    ClusterName     = var.cluster
    Namespace       = var.namespace
    DeploymentName  = var.deployment
    accountId       = var.account_id
  }

  metrics = [
    { label = "Replicas", color = "007CEF", expression = "sum(kube_deployment_status_replicas{deployment=\"${var.deployment}\", namespace=\"${var.namespace}\"})" },
  ]
}
