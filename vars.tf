variable "environment" {
  type = string
  description = "Environment"
}

variable "google_idp_app_id" {
  type = string
  description = "Google Identity Provider App Id"
}

variable "google_idp_app_secret" {
  type = string
  description = "Google Identity Provider App Secret"
}

locals {
  top_level_domain = "catalyst-${var.environment}"
  api_domain = "api.${local.top_level_domain}"
}