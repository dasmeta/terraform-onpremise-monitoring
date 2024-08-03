locals {
  data = {
    type = "text",
    datasource = {
      type = "datasource"
      uid  = "grafana"
    }
    options = {
      code = {
        language = "plaintext"
      }
      content = "## [${var.text}](${var.link_to_jump})"
      mode    = "markdown"
    }
    gridPos = {
      x = 0
      y = var.y
      h = 2
      w = var.width
    }
  }
}
