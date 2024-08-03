locals {
  field_config_defaults = {
    "color" : {
      "mode" : "palette-classic"
    },
    decimals : var.decimals,
    "custom" : {
      "axisLabel" : "",
      "axisPlacement" : "auto",
      "barAlignment" : 0,
      "drawStyle" : "line",
      "fillOpacity" : var.fillOpacity,
      "gradientMode" : "none",
      "hideFrom" : {
        "legend" : false,
        "tooltip" : false,
        "viz" : false
      },
      "lineInterpolation" : "linear",
      "lineWidth" : 1,
      "pointSize" : 5,
      "scaleDistribution" : {
        "type" : "linear"
      },
      "showPoints" : "auto",
      "spanNulls" : false,
      "stacking" : {
        "group" : "A",
        "mode" : "none"
      },
      "thresholdsStyle" : {
        "mode" : "off"
      }
    },
    mappings = []
    thresholds = {
      mode = "absolute"
      steps = [
        {
          color = "green"
          value = null
        },
        {
          color = "red"
          value = 80
        },
      ]
    }
  }

  common_fields    = ["MetricNamespace", "MetricName"]
  attribute_fields = ["accountId", "period", "stat", "label", "visible", "color", "yAxis"]
  custom_fields    = ["anomaly_detection", "anomaly_deviation"]
  metrics_local    = var.metrics == null ? [] : var.metrics

  # merge metrics with defaults
  metrics_with_defaults = [for metric in local.metrics_local : merge(var.defaults, metric)]

  type_map = {
    timeSeries = "timeseries"
    gauge      = "gauge"
    histogram  = "histogram"
  }

  # create query and metric based targets
  query_targets = var.query != null ? [
    {
      expression    = var.query,
      logGroupNames = var.sources,
      queryMode     = "Logs",
      legendFormat  = ""
      # region        = var.region
    }
  ] : []
  metric_targets = [for row in local.metrics_with_defaults : row.expression != null ? {
    expr         = row.expression
    id           = ""
    legendFormat = row.label,
    editorMode   = "code",

    } : {
    expression       = ""
    id               = ""
    matchExact       = true
    metricEditorMode = 0
    metricName       = row.MetricName
    metricQueryType  = 0
    namespace        = row.MetricNamespace
    period           = ""
    queryMode        = "Metrics"
    # region           = var.region
    sqlExpression = ""
    statistic     = "Average"
    dimensions    = { for key, item in row : key => item if !contains(concat(local.common_fields, local.attribute_fields, local.custom_fields), key) }
  }]

  data = {
    datasource = var.data_source
    fieldConfig = {
      defaults  = local.field_config_defaults
      overrides = []
    }
    gridPos = {
      h = var.coordinates.height
      w = var.coordinates.width
      x = var.coordinates.x
      y = var.coordinates.y
    }
    title = var.name
    type  = try(local.type_map[var.view], local.type_map.timeSeries)
    options = {
      legend = {
        calcs       = []
        displayMode = "list"
        placement   = "bottom"
      }
      tooltip = {
        mode = "single"
        sort = "none"
      }
    }
    targets = concat(local.query_targets, local.metric_targets)
  }
}
