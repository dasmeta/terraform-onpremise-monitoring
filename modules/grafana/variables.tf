
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

variable "enable_grafana" {
  type        = bool
  description = "flag to either enable or disable grafana deployment"
  default     = true
}

variable "prometheus_datasource" {
  type        = bool
  description = "boolean flag to enable prometheus datasource"
  default     = true
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

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "grafana_configs" {
  type = object({
    host = string
    resources = object({
      request = object({
        cpu = string
        mem = string
      })
      limit = object({
        cpu = string
        mem = string
      })
    })
    prometheus_url  = string
    certificate_arn = string
  })

  description = "Values to construct the values file for Grafana Helm chart"

  default = {
    host = ""
    resources = {
      request = {
        cpu = "1"
        mem = "2Gi"
      }
      limit = {
        cpu = "2"
        mem = "3Gi"
      }
    }
    prometheus_url  = "http://prometheus-operated.monitoring.svc.cluster.local:9090"
    certificate_arn = ""
  }
}
