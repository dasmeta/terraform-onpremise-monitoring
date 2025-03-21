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
      PROMETHEUS_URL      = var.grafana_configs.prometheus_url
      CLOUDWATCH_ENABLE   = var.cloudwatch_datasource
      CLOUDWATCH_ROLE_ARN = try(module.grafana_cloudwatch_role[0].arn, "")
      AWS_REGION          = var.aws_region
      INGRESS_CERTIFICATE = var.grafana_configs.certificate_arn
      HOST                = var.grafana_configs.host
      REQUEST_CPU         = try(local.grafana_configs.resources.request.cpu, "")
      REQUEST_MEMORY      = try(local.grafana_configs.resources.request.mem, "")
      LIMIT_CPU           = try(local.grafana_configs.resources.limit.cpu, "")
      LIMIT_MEMORY        = try(local.grafana_configs.resources.limit.mem, "")

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
