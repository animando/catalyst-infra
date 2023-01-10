resource "aws_ssm_parameter" "ui_distribution_domain" {
  name  = "catalyst-ui-distribution-domain"
  type  = "String"
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
}

# resource "aws_ssm_parameter" "kafka_broker_connect_string" {
#   name  = "catalyst-kafka-broker-connect-string"
#   type  = "String"
#   value = aws_msk_cluster.msk_cluster.bootstrap_brokers
# }

resource "aws_ssm_parameter" "kafka_cluster_id" {
  name  = "catalyst-kafka-cluster-id"
  type  = "String"
  value = aws_msk_cluster.msk_cluster.id
}

# resource "aws_ssm_parameter" "kafka_bootstrap_brokers_iam" {
#   name  = "catalyst-kafka-bootstrap-brokers-iam"
#   type  = "String"
#   value = aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
# }
