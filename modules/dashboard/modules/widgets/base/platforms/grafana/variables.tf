variable "name" {
  type = string
}

variable "data_source" {
  type = object({
    uid  = optional(string, null)
    type = optional(string, "prometheus")
  })
  description = "The custom datasource for widget item"
}

variable "coordinates" {
  type = object({
    x : number
    y : number
    width : number
    height : number
  })
}

variable "metrics" {
  type        = any
  default     = []
  description = "Metrics to be displayed on the widget."
}

variable "defaults" {
  type        = any
  default     = {}
  description = "Default values that will be passed to all metrics."
}

variable "stat" {
  type    = string
  default = "Average"
}

variable "period" {
  type    = number
  default = 3
}

# variable "region" {
#   type    = string
#   default = ""
# }

variable "anomaly_detection" {
  type        = bool
  default     = false
  description = "Allow to enable anomaly detection on widget metrics"
}

variable "anomaly_deviation" {
  type        = number
  default     = 4
  description = "Height of anomaly band"
}

variable "type" {
  type        = string
  default     = "metric"
  description = "The type of widget to be prepared"
}

variable "query" {
  type        = string
  default     = null
  description = "The Logs Insights complete build query without sources and other options(in case of metric) query"
}

variable "sources" {
  type        = list(string)
  default     = []
  description = "Log groups list for Logs Insights query"
}

variable "view" {
  type        = string
  default     = null
  description = "The view for log insights and alarm widgets"
}

variable "stacked" {
  type        = bool
  default     = null
  description = "The stacked option for log insights and alarm widgets"
}

variable "annotations" {
  type        = any
  default     = null
  description = "The annotations option for alarm widgets"
}

variable "alarms" {
  type        = list(string)
  default     = null
  description = "The list of alarm_arns used for properties->alarms option in alarm widgets"
}

variable "properties_type" {
  type        = string
  default     = null
  description = "The properties->type option for alarm widgets"
}

variable "decimals" {
  type        = number
  default     = 0
  description = "The decimals to enable on numbers"
}

variable "unit" {
  type        = string
  default     = ""
  description = "Unit used for widget metric"
}

variable "fillOpacity" {
  type        = number
  default     = 0
  description = "The fillOpacity value"
}

variable "options" {
  type = object({
    legend = object({
      calcs       = optional(list(string), [])
      displayMode = optional(string, "list")
      placement   = optional(string, "bottom")
      show_legend = optional(bool, true)
    })
    tooltip = optional(object({
      mode = optional(string, "single")
      sort = optional(string, "none")
    }), {})
  })
  default = {
    legend = {
      calcs       = []
      displayMode = "list"
      placement   = "bottom"
      show_legend = true
    }
    tooltip = {
      mode = "single"
      sort = "none"
    }
  }
  description = "Configuration options for widget legend and tooltip."
}

variable "description" {
  type        = string
  description = "Description for the widget"
  default     = ""
}
