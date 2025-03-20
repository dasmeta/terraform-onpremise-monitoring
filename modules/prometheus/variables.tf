variable "namespace" {
  type        = string
  description = "namespace to use for deployment"
  default     = "monitoring"
}

variable "prometheus_configs" {
  type        = map(any)
  description = "values to send to prometheus template values file"
  default = {
    retention_days      = "15d"
    storage_class       = "efs-sc"
    storage_size        = "50Gi"
    request_cpu         = "500m"
    request_mem         = "2Gi"
    limit_cpu           = "1000m"
    limit_mem           = "4Gi"
    enable_alertmanager = true
  }

}
