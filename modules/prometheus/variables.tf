variable "namespace" {
  type        = string
  description = "namespace to use for deployment"
  default     = "monitoring"
}

variable "enable_prometheus" {
  type        = bool
  description = "boolean flag to enable disable prometheus deployment"
  default     = true
}

variable "prometheus_configs" {
  type = object({
    retention_days = string
    storage_class  = string
    storage_size   = string
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
    enable_alertmanager = bool
  })

  description = "Values to send to Prometheus template values file"

  default = {
    retention_days = "15d"
    storage_class  = "efs-sc"
    storage_size   = "50Gi"
    resources = {
      request = {
        cpu = "500m"
        mem = "500Mi"
      }
      limit = {
        cpu = "1"
        mem = "1Gi"
      }
    }
    enable_alertmanager = true
  }
}
