resource "aws_elasticsearch_domain" "es_domain" {
  domain_name           = "es-domain"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "t3.medium.search"
    instance_count = 1
  }

  advanced_security_options {
    internal_user_database_enabled = true
    master_user_options {
      master_user_name = var.es_username
      master_user_password = var.password
    }
  }

  tags = {
    Name = "Logs ElasticSearch Domain"
    Project = "Catalyst"
  }
}
