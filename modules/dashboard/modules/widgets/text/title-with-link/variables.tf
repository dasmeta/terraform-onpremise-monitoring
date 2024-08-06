variable "text" {
  type = string
}

variable "link_to_jump" {
  type        = string
  description = "The URL to wich the user can be redirected after clicking on the title"
}

variable "y" {
  type = number
}

variable "width" {
  type    = number
  default = 24
}
