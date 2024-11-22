variable "namespace" {
  type        = string
  description = "k8s namespace name"
}

variable "redis_namespace" {
  type        = string
  description = "k8s redis namespace name"
}

variable "redis_name" {
  type        = string
  description = "Redis name"
  default     = "redis"
}

variable "redis_pod" {
  type        = string
  description = "Redis pod name, which may be the same with redis_name"
  default     = "redis"
}
