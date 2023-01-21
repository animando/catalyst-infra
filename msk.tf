resource "aws_kms_key" "msk_kms_key" {
  description = "MSK encryption key"
}

resource "aws_cloudwatch_log_group" "msk_broker_log_group" {
  name = "msk_broker_logs"
}

resource "aws_s3_bucket" "msk_bucket" {
  bucket = "animando-catalyst-msk-broker-logs-bucket"
}

resource "aws_s3_bucket_acl" "msk_bucket_acl" {
  bucket = aws_s3_bucket.msk_bucket.id
  acl    = "private"
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = "catalyst"
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = [
      aws_subnet.subnet_az1.id,
      aws_subnet.subnet_az2.id,
      aws_subnet.subnet_az3.id,
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 1000
      }
    }
    security_groups = [
      aws_security_group.msk_security_group.id,
      aws_security_group.allow_vpc_https_traffic.id
    ]
  }

  client_authentication {
    sasl {
        iam = true
    }
    unauthenticated = false
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.msk_kms_key.arn
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = false
      }
      node_exporter {
        enabled_in_broker = false
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_broker_log_group.name
      }
    }
  }

  tags = {
    Name = "Catalyst Kafka Cluster"
    Project = "Catalyst"
  }
}
