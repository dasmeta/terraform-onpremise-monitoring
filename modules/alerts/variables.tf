variable "alert_interval_seconds" {
  type        = number
  default     = 10
  description = "The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially."
}

variable "alert_rules" {
  type = list(object({
    name        = string                          # The name of the alert rule
    summary     = optional(string, "")            # Rule annotation as a summary
    folder_name = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created
    datasource  = string                          # Name of the datasource used for the alert
    metric_name = string                          # Prometheus metric name which queries the data for the alert
    filters     = optional(any, {})               # Filters object to identify each service for alerting
    function    = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting
    condition   = string                          # Math expression which compares B blocks value with a number and generates an alert if needed
  }))
  default     = []
  description = "This varibale describes alert folders, groups and rules."
}
