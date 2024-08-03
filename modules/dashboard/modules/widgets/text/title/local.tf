locals {
  data = {
    type = "text"
    datasource = {
      type = "datasource"
      uid  = "grafana"
    }
    options = {
      code = {
        language = "plaintext"
      }
      content = "## ${var.text}"
      mode    = "markdown"
    }
    gridPos = {
      x = 0
      y = var.y
      h = 2
      w = 24
    }
  }
}
