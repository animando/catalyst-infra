resource "aws_secretsmanager_secret" "userpool_client_secret" {
  name = "userpool_client_secret"

  tags = {
    Name = "Catalyst User Pool Client Secret"
    Project = "Catalyst"
  }
}
resource "aws_secretsmanager_secret" "google_idp_client_id" {
  name = "google_idp_client_id"

  tags = {
    Name = "Google Client Id"
    Project = "Catalyst"
  }
}

resource "aws_secretsmanager_secret" "google_idp_client_secret" {
  name = "google_idp_client_secret"

  tags = {
    Name = "Google Client Secret"
    Project = "Catalyst"
  }
}

resource "aws_secretsmanager_secret_version" "userpool_client_secret_version" {
  secret_id     = aws_secretsmanager_secret.userpool_client_secret.id
  secret_string = aws_cognito_user_pool_client.catalyst_cognito_client_app.client_secret
}
