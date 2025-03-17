
variable "namespace" {
  type        = string
  description = "namespace to use for deployment"
  default     = "monitoring"
}

variable "grafana_admin_password" {
  type        = string
  description = "admin password"
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

variable "prometheus_url" {
  type        = string
  default     = "http://prometheus-operated.monitoring.svc.cluster.local:9090"
  description = "url for prometheus datasource"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "certificate_arn" {
  type        = string
  description = "certificate arn for grafana"
  default     = "arn:aws:acm:us-east-2:774305617028:certificate/0c7b32a5-cfd3-488b-800c-fe289f3bb040"
}
