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

  }
}
