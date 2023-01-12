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

# resource "aws_iam_role" "msk_firehose_role" {
#   name = "firehose_test_role"

#   assume_role_policy = <<EOF
# {
# "Version": "2012-10-17",
# "Statement": [
#   {
#     "Action": "sts:AssumeRole",
#     "Principal": {
#       "Service": "firehose.amazonaws.com"
#     },
#     "Effect": "Allow",
#     "Sid": ""
#   }
#   ]
# }
# EOF
# }

# resource "aws_kinesis_firehose_delivery_stream" "msk_firehose_stream" {
#   name        = "terraform-kinesis-firehose-msk-broker-logs-stream"
#   destination = "s3"

#   s3_configuration {
#     role_arn   = aws_iam_role.msk_firehose_role.arn
#     bucket_arn = aws_s3_bucket.msk_bucket.arn
#   }

#   tags = {
#     LogDeliveryEnabled = "placeholder"
#   }

#   lifecycle {
#     ignore_changes = [
#       tags["LogDeliveryEnabled"],
#     ]
#   }
# }

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
    # connectivity_info {
    #     public_access {
    #       type = "SERVICE_PROVIDED_EIPS"
    #     }
    # }
    security_groups = [aws_security_group.msk_security_group.id]
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
    #   firehose {
    #     enabled         = true
    #     delivery_stream = aws_kinesis_firehose_delivery_stream.msk_firehose_stream.name
    #   }
    #   s3 {
    #     enabled = true
    #     bucket  = aws_s3_bucket.msk_bucket.id
    #     prefix  = "logs/msk-"
    #   }
    }
  }

  tags = {
    Project = "Catalyst"
  }
}
