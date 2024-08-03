# Title
module "text_title" {
  source = "./modules/widgets/text/title"

  for_each = { for index, item in try(local.widget_config["text/title"], []) : index => item }

  text = each.value.text
  y    = each.value.row
}

# Title with Link
module "text_title_with_link" {
  source = "./modules/widgets/text/title-with-link"

  for_each = { for index, item in try(local.widget_config["text/title-with-link"], []) : index => item }

  text         = each.value.text
  link_to_jump = each.value.link_to_jump
  y            = each.value.row
}

# Title with collapse
module "text_title_with_collapse" {
  source = "./modules/widgets/text/title-with-collapse"

  for_each = { for index, item in try(local.widget_config["text/title-with-collapse"], []) : index => item }

  text = each.value.text
  y    = each.value.row
}
