# Deploy Prometheus
resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  timeout          = 600

  values = [
    templatefile("${path.module}/values/prometheus-values.yaml", {
      RETENTION_DAYS      = var.prometheus_configs.retention_days
      STORAGE_CLASS_NAME  = var.prometheus_configs.storage_class
      STORAGE_SIZE        = var.prometheus_configs.storage_size
      REQUEST_CPU         = var.prometheus_configs.request_cpu
      REQUEST_MEM         = var.prometheus_configs.request_mem
      LIMIT_CPU           = var.prometheus_configs.limit_cpu
      LIMIT_MEM           = var.prometheus_configs.limit_mem
      ENABLE_ALERTMANAGER = var.prometheus_configs.enable_alertmanager
    })

  ]
}
