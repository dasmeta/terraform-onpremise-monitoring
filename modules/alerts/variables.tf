variable "alert_interval_seconds" {
  type        = number
  default     = 10
  description = "The interval, in seconds, at which all rules in the group are evaluated. If a group contains many rules, the rules are evaluated sequentially."
}

variable "alert_rules" {
  type = list(object({
    name            = string                          # The name of the alert rule
    summary         = optional(string, "")            # Rule annotation as a summary
    priority        = optional(string, "P2")          # Rule priority level: P2 is for non-critical alerts, P1 will be set for critical alerts
    folder_name     = optional(string, "Main Alerts") # Grafana folder name in which the rule will be created
    datasource      = string                          # Name of the datasource used for the alert
    metric_name     = string                          # Prometheus metric name which queries the data for the alert
    metric_function = optional(string, "")            # Prometheus function used with metric for queries, like rate, sum etc.
    metric_interval = optional(string, "")            # The time interval with using functions like rate
    filters         = optional(any, {})               # Filters object to identify each service for alerting
    function        = optional(string, "mean")        # One of Reduce functions which will be used in B block for alerting
    equation        = string                          # The equation in the math expression which compares B blocks value with a number and generates an alert if needed. Possible values: gt, lt, gte, lte, e
    threshold       = number                          # The value against which B blocks are compared in the math expression
  }))
  default     = []
  description = "This varibale describes alert folders, groups and rules."
}
