locals {
  folders = toset(distinct([for rule in var.alert_rules : rule.folder_name]))
  alerts  = { for member in local.folders : member => [for rule in var.alert_rules : rule if rule.folder_name == member] }
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
      no_data_state  = "NoData"
      exec_err_state = "Error"
      annotations = {
        "Managed By" = "Terraform"
        "Summary"    = lookup(rule.value, "summary", rule.value.name)
      }
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
    "expr": "${rule.value.metric_name}${(rule.value.filters != null && length(rule.value.filters) > 0) ? format("{%s}", replace(join(", ", [for k, v in rule.value.filters : "${k}=\"${v}\""]), "\"", "\\\"")) : ""}",
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
    "type": "reduce"
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
    "expression": "${rule.value.condition}",
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
