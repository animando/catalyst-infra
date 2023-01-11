# Cloudfront

resource "aws_ssm_parameter" "ui_distribution_domain" {
  name  = "catalyst-ui-distribution-domain"
  type  = "String"
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
}

# MSK

# resource "aws_ssm_parameter" "kafka_broker_connect_string" {
#   name  = "catalyst-kafka-broker-connect-string"
#   type  = "String"
#   value = aws_msk_cluster.msk_cluster.bootstrap_brokers
# }

resource "aws_ssm_parameter" "kafka_cluster_name" {
  name  = "catalyst-kafka-cluster-name"
  type  = "String"
  value = aws_msk_cluster.msk_cluster.cluster_name
}

resource "aws_ssm_parameter" "kafka_cluster_id" {
  name  = "catalyst-kafka-cluster-id"
  type  = "String"
  value = aws_msk_cluster.msk_cluster.id
}
resource "aws_ssm_parameter" "kafka_cluster_arn" {
  name  = "catalyst-kafka-cluster-arn"
  type  = "String"
  value = aws_msk_cluster.msk_cluster.arn
}

resource "aws_ssm_parameter" "kafka_bootstrap_brokers_iam" {
  name  = "catalyst-kafka-bootstrap-brokers-iam"
  type  = "String"
  value = aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
}

# resource "aws_ssm_parameter" "kafka_bootstrap_brokers_tls" {
#   name  = "catalyst-kafka-bootstrap-brokers-tls"
#   type  = "String"
#   value = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
# }

# VPC

resource "aws_ssm_parameter" "msk_subnet_az1_id" {
  name  = "msk-subnet-az1-id"
  type  = "String"
  value = aws_subnet.subnet_az1.id
}

resource "aws_ssm_parameter" "msk_subnet_az2_id" {
  name  = "msk-subnet-az2-id"
  type  = "String"
  value = aws_subnet.subnet_az2.id
}

resource "aws_ssm_parameter" "msk_subnet_az3_id" {
  name  = "msk-subnet-az3-id"
  type  = "String"
  value = aws_subnet.subnet_az3.id
}

resource "aws_ssm_parameter" "msk_security_group_id" {
  name  = "msk-security-group-id"
  type  = "String"
  value = aws_security_group.msk_security_group.id
}
