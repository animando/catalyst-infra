resource "aws_opensearch_domain" "os_domain" {
  domain_name           = "os-domain"

  engine_version = "OpenSearch_2.3"

  cluster_config {
    instance_type = "t3.medium.search"
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
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = {
    Name = "Logs ElasticSearch Domain"
    Project = "Catalyst"
  }
}
