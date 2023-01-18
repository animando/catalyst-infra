variable "environment" {
  type = string
  description = "Environment"
}

locals {
  top_level_domain = "catalyst-${var.environment}"
  api_domain = "api.${local.top_level_domain}"
}