locals {
  folders = toset(distinct([for rule in var.alert_rules : rule.folder_name]))
  alerts = { for member in local.folders : member => [for rule in var.alert_rules : merge(rule, {
    expr : coalesce(rule.expr, "${rule.metric_function}(${rule.metric_name}${(rule.filters != null && length(rule.filters) > 0) ? format("{%s}", replace(join(", ", [for k, v in rule.filters : "${k}=\"${v}\""]), "\"", "\\\"")) : ""}${rule.metric_interval})")
  }) if rule.folder_name == member] }
  comparison_operators = {
    gte : ">=",
    gt : ">",
    lt : "<",
    lte : "<=",
    e : "="
  }
}

resource "grafana_folder" "rule_folder" {
  for_each = local.folders
  title    = each.key
}

resource "grafana_rule_group" "alert_rule" {
  for_each = local.alerts

  name             = "${each.key} Group"
  folder_uid       = grafana_folder.rule_folder[each.key].uid
  interval_seconds = var.alert_interval_seconds
  org_id           = 1
  dynamic "rule" {
    for_each = each.value
    content {
      name           = rule.value["name"]
      for            = "0"
      condition      = "C"
      no_data_state  = lookup(rule.value, "no_data_state", "NoData")
      exec_err_state = lookup(rule.value, "exec_err_state", "Error")
      annotations = {
        "Managed By" = "Terraform"
        "Summary"    = lookup(rule.value, "summary", rule.value.name)
      }
      labels = lookup(rule.value, "labels", {
        "priorityLow" : "true"
      })
      is_paused = false
      data {
        ref_id     = "A"
        query_type = ""
        relative_time_range {
          from = 600
          to   = 0
        }
        datasource_uid = rule.value.datasource
        model          = <<EOT
{
    "editorMode": "code",
    "expr": "${rule.value.expr}",
    "hide": false,
    "intervalMs": "1000",
    "legendFormat": "__auto",
    "maxDataPoints": "43200",
    "range": true,
    "refId": "A"
}
EOT
      }
      data {
        ref_id     = "B"
        query_type = ""
        relative_time_range {
          from = 600
          to   = 0
        }
        datasource_uid = "__expr__"
        model          = <<EOT
{
    "conditions": [
        {
        "evaluator": {
            "params": [
            0,
            0
            ],
            "type": "gt"
        },
        "operator": {
            "type": "and"
        },
        "query": {
            "params": []
        },
        "reducer": {
            "params": [],
            "type": "last"
        },
        "type": "query"
        }
    ],
    "datasource": {
        "name": "Expression",
        "type": "__expr__",
        "uid": "__expr__"
    },
    "expression": "A",
    "intervalMs": 1000,
    "maxDataPoints": 43200,
    "reducer": "${rule.value.function}",
    "refId": "B",
    "type": "reduce",
    "settings": {
        "mode": "${rule.value.settings_mode}",
        "replaceWithValue": ${rule.value.settings_replaceWith}
    }
}
EOT
      }
      data {
        ref_id     = "C"
        query_type = ""
        relative_time_range {
          from = 600
          to   = 0
        }
        datasource_uid = "__expr__"
        model          = <<EOT
{
    "conditions": [
        {
        "evaluator": {
            "params": [
            0,
            0
            ],
            "type": "gt"
        },
        "operator": {
            "type": "and"
        },
        "query": {
            "params": []
        },
        "reducer": {
            "params": [],
            "type": "last"
        },
        "type": "query"
        }
    ],
    "datasource": {
        "name": "Expression",
        "type": "__expr__",
        "uid": "__expr__"
    },
    "expression": "$B ${local.comparison_operators[rule.value.equation]} ${rule.value.threshold}",
    "hide": false,
    "intervalMs": 1000,
    "maxDataPoints": 43200,
    "refId": "C",
    "type": "math"
}
EOT
      }
    }
  }
}
