variable "notifications" {
  type = object({
    contact_point   = optional(string, "Slack")       # The default contact point to route all unmatched notifications to.
    group_by        = optional(list(string), ["..."]) # A list of alert labels to group alerts into notifications by.
    group_interval  = optional(string, "5m")          # Minimum time interval between two notifications for the same group.
    repeat_interval = optional(string, "4h")          # Minimum time interval for re-sending a notification if an alert is still firing.

    policies = optional(list(object({
      contact_point = optional(string, null) # The contact point to route notifications that match this rule to.
      continue      = optional(bool, false)  # Whether to continue matching subsequent rules if an alert matches the current rule. Otherwise, the rule will be 'consumed' by the first policy to match it.
      group_by      = optional(list(string), ["..."])
      mute_timings  = optional(list(string), []) # A list of mute timing names to apply to alerts that match this policy.

      matchers = optional(list(object({
        label = optional(string, "priority") # The name of the label to match against.
        match = optional(string, "=")        # The operator to apply when matching values of the given label. Allowed operators are = for equality, != for negated equality, =~ for regex equality, and !~ for negated regex equality.
        value = optional(string, "P1")       # The label value to match against.
      })), [])
    })), [])
  })
  description = "Represents the configuration options for Grafana notification policies."
  default     = {}
}
