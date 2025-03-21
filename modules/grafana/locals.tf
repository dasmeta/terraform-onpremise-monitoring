locals {
  cloudwatch_policies = [
    {
      actions = [
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetInsightRuleReport"
      ],
      resources = ["*"]
    },
    {
      actions   = ["ec2:DescribeTags", "ec2:DescribeInstances", "ec2:DescribeRegions"],
      resources = ["*"]
    },
    {
      actions   = ["tag:GetResources"],
      resources = ["*"]
    },
    {
      actions   = ["pi:GetResourceMetrics"],
      resources = ["*"]
    },
    {
      actions = [
        "logs:DescribeLogGroups",
        "logs:GetLogGroupFields",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:GetQueryResults",
        "logs:GetLogEvents"
      ],
      resources = ["*"]
    },
  ]

  grafana_configs = {
    cloudwatch_enable_datasource = try(var.grafana_configs.cloudwatch_datasource, true),
    request_cpu                  = try(var.grafana_configs.grafana_resources.request_cpu, "2000m")
    request_mem                  = try(var.grafana_configs.grafana_resources.request_memory, "2000M")
    limit_cpu                    = try(var.grafana_configs.grafana_resources.limit_cpu, "2000m")
    limit_mem                    = try(var.grafana_configs.grafana_resources.limit_mem, "2000M")
    ingress_configs = {
      annotations = (
        contains(keys(try(var.grafana_configs.ingress_configs, {})), "annotations")
        ? var.grafana_configs.ingress_configs.annotations
        : {
          "kubernetes.io/ingress.class"                = "alb"
          "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
          "alb.ingress.kubernetes.io/target-type"      = "ip"
          "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\": 80}]"
          "alb.ingress.kubernetes.io/group.name"       = "monitoring"
          "alb.ingress.kubernetes.io/healthcheck-path" = "/api/health"
        }
      )

      hosts     = try(var.grafana_configs.ingress_configs.hosts, ["grafana.example.com"])
      path      = try(var.grafana_configs.ingress_configs.path, "/")
      path_type = try(var.grafana_configs.ingress_configs.path_type, "Prefix")
    }
  }
}
