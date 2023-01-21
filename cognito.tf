resource "aws_cognito_user_pool" "user_pool" {
  name = "catalyst-user-pool"

  lifecycle {
    ignore_changes = [
      lambda_config
    ]
  }

  tags = {
    Name = "Catalyst User Pool"
    Project = "Catalyst"
  }
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain = "catalyst-ui"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool_client" "catalyst_cognito_client_app" {
  name = "catalyst_ui"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = true
  callback_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}"]
  logout_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["email", "openid", "profile", local.fq_webapi_access_scope]
  supported_identity_providers = ["COGNITO", aws_cognito_identity_provider.google_idp.provider_name]

  depends_on = [
    aws_cognito_resource_server.catalyst_web_api
  ]
}

resource "aws_cognito_user_group" "admin_user_group" {
  name = "admin"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  description = "Admin"
}

resource "aws_cognito_identity_provider" "google_idp" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id

  provider_name = "Google"
  provider_type = "Google"

  lifecycle {
    ignore_changes = [
      provider_details
    ]
  }

  provider_details = {
    authorize_scopes = "email"
    client_id        = aws_secretsmanager_secret.google_idp_client_id.id
    client_secret    = aws_secretsmanager_secret.google_idp_client_secret.id
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

locals {
  webapi_access_scope = "webapi.access"
  resource_server_identifier = "https://${local.api_domain}"
  fq_webapi_access_scope = "${local.resource_server_identifier}/${local.webapi_access_scope}"
}

resource "aws_cognito_resource_server" "catalyst_web_api" {
  identifier = local.resource_server_identifier
  name = "Catalyst web api"

  scope {
    scope_name = local.webapi_access_scope
    scope_description = "Allow access to catalyst web api"
  }

  user_pool_id = aws_cognito_user_pool.user_pool.id
}
