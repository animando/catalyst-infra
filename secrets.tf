resource "aws_secretsmanager_secret" "userpool_client_secret" {
  name = "userpool_client_secret"

  tags = {
    Project = "Catalyst"
  }
}
resource "aws_secretsmanager_secret" "google_idp_client_id" {
  name = "google_idp_client_id"

  tags = {
    Project = "Catalyst"
  }
}

resource "aws_secretsmanager_secret" "google_idp_client_secret" {
  name = "google_idp_client_secret"

  tags = {
    Project = "Catalyst"
  }
}

resource "aws_secretsmanager_secret_version" "userpool_client_secret_version" {
  secret_id     = aws_secretsmanager_secret.userpool_client_secret.id
  secret_string = aws_cognito_user_pool_client.catalyst_cognito_client_app.client_secret
}

resource "aws_secretsmanager_secret_version" "google_idp_client_id_version" {
  secret_id     = aws_secretsmanager_secret.google_idp_client_id.id
  secret_string = "default"
}

resource "aws_secretsmanager_secret_version" "google_idp_client_secret_version" {
  secret_id     = aws_secretsmanager_secret.google_idp_client_secret.id
  secret_string = "default"
}
