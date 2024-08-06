locals {
  data = {
    type      = "row"
    collapsed = false
    panels    = []
    title     = var.text
    gridPos = {
      x = 0
      y = var.y
      h = 2
      w = 24
    }
  }
}
