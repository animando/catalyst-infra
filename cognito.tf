resource "aws_cognito_user_pool" "user_pool" {
  name = "catalyst-user-pool"

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
  callback_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}/login"]
  logout_urls = ["https://${aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name}/logout"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_group" "admin_user_group" {
    name = "admin"
    user_pool_id = aws_cognito_user_pool.user_pool.id
    description = "Admin"
}
