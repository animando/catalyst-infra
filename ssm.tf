# Cloudfront

# resource "aws_ssm_parameter" "ui_distribution_domain" {
#   name  = "catalyst-ui-distribution-domain"
#   type  = "String"
#   value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
# }

# resource "aws_ssm_parameter" "ui_distribution_id" {
#   name  = "catalyst-ui-distribution-id"
#   type  = "String"
#   value = aws_cloudfront_distribution.ui_cloudfront_distribution.id
# }

# MSK

# resource "aws_ssm_parameter" "kafka_cluster_name" {
#   name  = "catalyst-kafka-cluster-name"
#   type  = "String"
#   value = "disabled"#aws_msk_cluster.msk_cluster.cluster_name
# }

# resource "aws_ssm_parameter" "kafka_cluster_id" {
#   name  = "catalyst-kafka-cluster-id"
#   type  = "String"
#   value = "disabled"#split("/", aws_msk_cluster.msk_cluster.id)[2]
# }
# resource "aws_ssm_parameter" "kafka_cluster_arn" {
#   name  = "catalyst-kafka-cluster-arn"
#   type  = "String"
#   value = "disabled"#aws_msk_cluster.msk_cluster.arn
# }

# resource "aws_ssm_parameter" "kafka_bootstrap_brokers_iam" {
#   name  = "catalyst-kafka-bootstrap-brokers-iam"
#   type  = "String"
#   value = "disabled"#aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
# }

# VPC

# resource "aws_ssm_parameter" "private_subnet_az1_id" {
#   name  = "private-subnet-az1-id"
#   type  = "String"
#   value = aws_subnet.subnet_az1.id
# }

# resource "aws_ssm_parameter" "private_subnet_az2_id" {
#   name  = "private-subnet-az2-id"
#   type  = "String"
#   value = aws_subnet.subnet_az2.id
# }

# resource "aws_ssm_parameter" "private_subnet_az3_id" {
#   name  = "private-subnet-az3-id"
#   type  = "String"
#   value = aws_subnet.subnet_az3.id
# }

# resource "aws_ssm_parameter" "public_subnet_az1_id" {
#   name  = "public-subnet-az1-id"
#   type  = "String"
#   value = aws_subnet.public_subnet_az1.id
# }

# resource "aws_ssm_parameter" "public_subnet_az2_id" {
#   name  = "public-subnet-az2-id"
#   type  = "String"
#   value = aws_subnet.public_subnet_az2.id
# }

# resource "aws_ssm_parameter" "public_subnet_az3_id" {
#   name  = "public-subnet-az3-id"
#   type  = "String"
#   value = aws_subnet.public_subnet_az3.id
# }

# resource "aws_ssm_parameter" "msk_security_group_id" {
#   name  = "msk-security-group-id"
#   type  = "String"
#   value = aws_security_group.msk_security_group.id
# }

# resource "aws_ssm_parameter" "lambda_security_group_id" {
#   name  = "lambda-security-group-id"
#   type  = "String"
#   value = aws_security_group.lambda_security_group.id
# }

# resource "aws_ssm_parameter" "vpc_endpoint_id" {
#   name  = "execute-api-vpc-endpoint-id"
#   type  = "String"
#   value = aws_vpc_endpoint.execute-api_vpc_endpoint.id
# }

# Cognito

# resource "aws_ssm_parameter" "user_pool_client_id" {
#   name  = "user-pool-client-id"
#   type  = "String"
#   value = aws_cognito_user_pool_client.catalyst_cognito_client_app.id
# }

# resource "aws_ssm_parameter" "user_pool_id" {
#   name  = "user-pool-id"
#   type  = "String"
#   value = aws_cognito_user_pool.user_pool.id
# }

# resource "aws_ssm_parameter" "user_pool_name" {
#   name  = "user-pool-name"
#   type  = "String"
#   value = aws_cognito_user_pool.user_pool.name
# }

# resource "aws_ssm_parameter" "user_pool_arn" {
#   name  = "user-pool-arn"
#   type  = "String"
#   value = aws_cognito_user_pool.user_pool.arn
# }

# resource "aws_ssm_parameter" "user_pool_domain" {
#   name  = "user-pool-domain"
#   type  = "String"
#   value = aws_cognito_user_pool_domain.user_pool_domain.domain
# }

# resource "aws_ssm_parameter" "cognito_ui_endpoint" {
#   name  = "cognito-ui-endpoint"
#   type  = "String"
#   value = "https://${aws_cognito_user_pool_domain.user_pool_domain.domain}.auth.${data.aws_region.current.name}.amazoncognito.com"
# }

# resource "aws_ssm_parameter" "webapi_access_scope" {
#   name  = "webapi-access-scope"
#   type  = "String"
#   value = local.fq_webapi_access_scope
# }

# Secrets

# resource "aws_ssm_parameter" "user_pool_client_secret_arn" {
#   name = "user-pool-client-secret-arn"
#   type = "String"
#   value = aws_secretsmanager_secret.cognito_userpool_client_secret.arn
# }

# OpenSearch

# resource "aws_ssm_parameter" "os_domain_arn" {
#   name = "os-domain-arn"
#   type = "String"
#   value = aws_opensearch_domain.os_domain.arn
# }

# resource "aws_ssm_parameter" "os_logging_role_arn" {
#   name = "os-logging-role-arn"
#   type = "String"
#   value = aws_iam_role.os_log_writing_role.arn
# }
