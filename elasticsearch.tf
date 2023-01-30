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

  tags = {
    Name = "Logs ElasticSearch Domain"
    Project = "Catalyst"
  }
}