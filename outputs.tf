# MSK

output "zookeeper_connect_string" {
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}

output "bootstrap_brokers" {
  description = "bootstrap brokers"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers
}

output "bootstrap_brokers_iam" {
  description = "bootstrap brokers iam"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
}

output "msk_cluster_arn" {
  description = "msk cluster arn"
  value       = aws_msk_cluster.msk_cluster.arn
}

output "msk_cluster_id" {
  description = "msk cluster id"
  value       = aws_msk_cluster.msk_cluster.id
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
