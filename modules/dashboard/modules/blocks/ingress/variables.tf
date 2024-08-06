variable "account_id" {
  type        = string
  description = "AWS account ID"
}

variable "balancer_name" {
  type        = string
  description = "ALB name"
}

variable "region" {
  type    = string
  default = ""
}
