# resource "aws_elasticsearch_domain" "es_domain" {
#   domain_name           = "es-domain"
#   elasticsearch_version = "7.10"

#   cluster_config {
#     instance_type = "r4.large.elasticsearch"
#   }

#   tags = {
#     Name = "Logs ElasticSearch Domain"
#     Project = "Catalyst"
#   }
# }
resource "aws_cognito_identity_pool" "es-identity-pool" {
  identity_pool_name               = "es-identity-pool"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.catalyst_cognito_client_app.id
    provider_name           = aws_cognito_user_pool.user_pool.id
    server_side_token_check = false
  }
}
