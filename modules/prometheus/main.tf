# Deploy Prometheus
resource "helm_release" "prometheus" {
  count = var.enable_prometheus ? 1 : 0

  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  timeout          = 600

  values = [
    templatefile("${path.module}/values/prometheus-values.yaml.tpl", {
      RETENTION_DAYS      = var.prometheus_configs.retention_days
      STORAGE_CLASS_NAME  = var.prometheus_configs.storage_class
      STORAGE_SIZE        = var.prometheus_configs.storage_size
      REQUEST_CPU         = try(var.prometheus_configs.resources.request.cpu, "")
      REQUEST_MEM         = try(var.prometheus_configs.resources.request.mem, "")
      LIMIT_CPU           = try(var.prometheus_configs.resources.limit.cpu, "")
      LIMIT_MEM           = try(var.prometheus_configs.resources.limit.mem, "")
      ENABLE_ALERTMANAGER = var.prometheus_configs.enable_alertmanager
    })

  ]
}
