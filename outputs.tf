# MSK

output "zookeeper_connect_string" {
  value = "disabled" #aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

output "bootstrap_brokers_iam" {
  description = "bootstrap brokers iam"
  value       = "disabled" #aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
}

output "msk_cluster_arn" {
  description = "msk cluster arn"
  value       = "disabled" #aws_msk_cluster.msk_cluster.arn
}

output "msk_cluster_name" {
  description = "msk cluster name"
  value       = "disabled" #aws_msk_cluster.msk_cluster.cluster_name
}

output "msk_cluster_id" {
  description = "msk cluster id"
  value       = "disabled" #split("/", aws_msk_cluster.msk_cluster.id)[2]
}

# S3

output "s3_website_address" {
  value = aws_s3_bucket.ui_website_bucket.bucket_regional_domain_name
}

# Cloudfront

output "cloudfront_address" {
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
}
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.id
}

output "vpc_endpoint_id" {
  description = "VPC Endpoint id"
  value = aws_vpc_endpoint.execute-api_vpc_endpoint.id
}

# VPC

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_az1_id" {
  value = aws_subnet.subnet_az1.id
}

output "subnet_az2_id" {
  value = aws_subnet.subnet_az2.id
}

output "subnet_az3_id" {
  value = aws_subnet.subnet_az3.id
}

output "msk_security_group_id" {
  value = aws_security_group.msk_security_group.id
}

output "lambda_security_group_id" {
  value = aws_security_group.lambda_security_group.id
}

# Cognito

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.catalyst_cognito_client_app.id
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.user_pool.arn
}

output "cognito_ui_endpoint" {
  value = "${aws_cognito_user_pool_domain.user_pool_domain.domain}.auth.${data.aws_region.current.name}.amazoncognito.com"
}

# Elastic Search

# output "es_endpoint" {
#   value = aws_elasticsearch_domain.es_domain.endpoint
# }

# output "es_domain_name" {
#   value = aws_elasticsearch_domain.es_domain.domain_name
# }

# output "es_domain_id" {
#   value = aws_elasticsearch_domain.es_domain.domain_id
# }

output "os_log_writing_role_arn" {
  value = aws_iam_role.os_log_writing_role.arn
}

# output "es_arn" {
#   value = aws_elasticsearch_domain.es_domain.arn
# }
# output "es_kibana_endpoint" {
#   value = aws_elasticsearch_domain.es_domain.kibana_endpoint
# }

# output "debug1" {
#   value = data.aws_region.current.name
# }
# output "debug2" {
#   value = data.aws_caller_identity.current.account_id
# }
# output "debug3" {
#   value = var.es_domain
# }