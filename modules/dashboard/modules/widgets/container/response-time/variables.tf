variable "data_source" {
  type = object({
    uid  = optional(string, null)
    type = optional(string, "prometheus")
  })
  description = "The custom datasource for widget item"
}

variable "host" {
  type    = string
  default = null
}

variable "problem" {
  type        = number
  default     = 2
  description = "The number which indicates the max timeout above which we have problem"
}

variable "acceptable" {
  type        = number
  default     = 1
  description = "The number which indicates the acceptable timeout"
}

variable "target_group_name" {
  type    = string
  default = null
}

variable "balancer_name" {
  type    = string
  default = null
}

variable "account_id" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = ""
}

# position
variable "coordinates" {
  type = object({
    x : number
    y : number
    width : number
    height : number
  })
}

# stats
variable "period" {
  type    = number
  default = 3
}

variable "anomaly_detection" {
  type        = bool
  default     = false
  description = "Allow to enable anomaly detection on widget metrics"
}

variable "anomaly_deviation" {
  type        = number
  default     = 6
  description = "Deviation of the anomaly band"
}
