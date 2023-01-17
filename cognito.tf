resource "aws_cognito_user_pool" "user_pool" {
  name = "catalyst-user-pool"

  lifecycle {
    ignore_changes = [
      lambda_config[0].pre_token_generation
    ]
  }

  tags = {
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
  callback_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}","http://localhost:5173"]
  logout_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}/logout"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  supported_identity_providers = ["COGNITO"]
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

  provider_details = {
    authorize_scopes = "email"
    client_id        = aws_secretsmanager_secret.google_idp_client_id
    client_secret    = aws_secretsmanager_secret.google_idp_client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}
