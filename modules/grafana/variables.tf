
variable "namespace" {
  type        = string
  description = "namespace to use for deployment"
  default     = "monitoring"
}

variable "grafana_admin_password" {
  type        = string
  description = "admin password"
  default     = ""
}

variable "folder_uid" {
  type    = string
  default = ""
}

variable "cloudwatch_datasource" {
  type        = bool
  default     = true
  description = "boolean flag to enable cloudwatch datasource"
}

# variable "prometheus_url" {
#   type        = string
#   default     = "http://prometheus-operated.monitoring.svc.cluster.local:9090"
#   description = "url for prometheus datasource"
# }

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

# variable "certificate_arn" {
#   type        = string
#   description = "certificate arn for grafana ingress"
#   default     = ""
# }

variable "grafana_configs" {
  type        = map(any)
  description = "values to construct the values file for grafana chart"
  default = {
    host            = ""
    request_cpu     = "500m"
    request_mem     = "2Gi"
    limit_cpu       = "1000m"
    limit_mem       = "4Gi"
    prometheus_url  = "http://prometheus-operated.monitoring.svc.cluster.local:9090"
    certificate_arn = ""
  }
}
