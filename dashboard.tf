module "application_dashboard" {
  source = "./modules/dashboard/"

  count = length(var.application_dashboard) > 0 ? 1 : 0

  name        = var.name
  rows        = var.application_dashboard.rows
  data_source = var.application_dashboard.data_source
  variables   = var.application_dashboard.variables
}
