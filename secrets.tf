# resource "aws_secretsmanager_secret" "cognito_userpool_client_secret" {
#   name = "cognito_userpool_client_secret"

#   recovery_window_in_days = 0

#   tags = {
#     Name = "Catalyst User Pool Client Secret"
#     Project = "Catalyst"
#   }
# }

# resource "aws_secretsmanager_secret_version" "cognito_userpool_client_secret_version" {
#   secret_id     = aws_secretsmanager_secret.cognito_userpool_client_secret.id
#   secret_string = aws_cognito_user_pool_client.catalyst_cognito_client_app.client_secret
# }
