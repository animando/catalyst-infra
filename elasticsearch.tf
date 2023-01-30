resource "aws_elasticsearch_domain" "es_domain" {
  domain_name           = "es-domain"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "t3.medium.elasticsearch"
    instance_count = 1
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name = var.es_username
      master_user_password = var.es_password
    }
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp3"
    throughput = 125
  }

  tags = {
    Name = "Logs ElasticSearch Domain"
    Project = "Catalyst"
  }
}
