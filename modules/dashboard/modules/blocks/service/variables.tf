variable "name" {
  type        = string
  description = "Service nameD"
}

variable "balancer_name" {
  type        = string
  description = "ALB name"
}

variable "target_group_arn" {
  type        = string
  description = "Target group ARN which points to the service"
}

variable "healthcheck_id" {
  type        = string
  description = "R53 healthcheck ID for the service"
}

variable "cluster" {
  type        = string
  description = "EKS cluster name"
}

variable "namespace" {
  type        = string
  description = "EKS namespace name"
}

variable "region" {
  type    = string
  default = ""
}

variable "version_label" {
  type        = string
  description = "The deployment label which shows app version"
  default     = "app-version"
}

variable "log_group_name" {
  type        = string
  description = "The log group name where app sends logs"
}

variable "host" {
  type        = string
  default     = null
  description = "The service host name"
}
