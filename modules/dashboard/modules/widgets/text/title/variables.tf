variable "text" {
  type = string
}

variable "y" {
  type = number
}

variable "collapse" {
  type        = bool
  default     = true
  description = "Whether the title block will be collapse to wrap next coming blocks"
}
