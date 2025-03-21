# Deploy Grafana
resource "helm_release" "grafana" {
  count            = var.enable_grafana ? 1 : 0
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = var.namespace
  create_namespace = true
  timeout          = 600
  version          = "8.5.6"

  values = [
    templatefile("${path.module}/values/grafana-values.yaml.tpl", {
      PROMETHEUS_ENABLE   = coalesce(try(var.prometheus_datasource, null), false)
      PROMETHEUS_URL      = coalesce(try(var.grafana_configs.prometheus_url, null), "")
      CLOUDWATCH_ENABLE   = coalesce(try(var.cloudwatch_datasource, null), false)
      CLOUDWATCH_ROLE_ARN = coalesce(try(module.grafana_cloudwatch_role[0].arn, null), "")
      AWS_REGION          = coalesce(try(var.aws_region, null), "eu-central-1")
      REQUEST_CPU         = coalesce(try(local.grafana_configs.resources.request.cpu, null), "500m")
      REQUEST_MEMORY      = coalesce(try(local.grafana_configs.resources.request.mem, null), "512Mi")
      LIMIT_CPU           = coalesce(try(local.grafana_configs.resources.limit.cpu, null), "1")
      LIMIT_MEMORY        = coalesce(try(local.grafana_configs.resources.limit.mem, null), "1Gi")
      INGRESS_ANNOTATIONS = coalesce(try(local.grafana_configs.ingress_configs.annotations, null), {})
      INGRESS_HOSTS       = coalesce(try(var.grafana_configs.ingress_configs.hosts, null), ["grafana.example.com"])
      INGRESS_PATH        = coalesce(try(local.grafana_configs.ingress_configs.path, null), "/")
      INGRESS_PATH_TYPE   = coalesce(try(local.grafana_configs.ingress_configs.path_type, null), "Prefix")
    })
  ]

  set {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }
}


module "grafana_cloudwatch_role" {
  count   = var.cloudwatch_datasource ? 1 : 0
  source  = "dasmeta/iam/aws//modules/role"
  version = "1.3.0"

  name   = "grafana-cloudwatch-role"
  policy = local.cloudwatch_policies
  trust_relationship = [
    {
      principals = {
        type        = "Service"
        identifiers = ["eks.amazonaws.com", ]
      },
      actions = ["sts:AssumeRole"]
    }
  ]
}
