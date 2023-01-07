terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "http" {
    address        = "https://api.tfstate.dev/github/v1"
    lock_address   = "https://api.tfstate.dev/github/v1/lock"
    unlock_address = "https://api.tfstate.dev/github/v1/lock"
    lock_method    = "PUT"
    unlock_method  = "DELETE"
    username       = "animando/catalyst-infra"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ec2_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVTZbGwOv74erhzWL7Xx24dRYyhrO9bRrDmN6Jj0LgnM9GkGv/IqND+L32V7XBAQ6drEqmULwSPJH1LYAELPQyNlZdKOh7m2Cg6QFbGh4FzpFKsRGJp+4hhzIZ3lWMriUF68u3sXSb8Bji9eGanV2uAWx6DLDNKs2XYFwxtPH/pPywcY7FF/SAStZ9SrrGecJZUXi3EnqqzLjvemxnBmsl8cT4wHlUg+mab7IdVFz0TwyExRGK+1AUWElJ1hKVGROpm2CeejdBcuMyYrgvoQgWWOhm4r0ryVXC+iFv6427s3aBSO5XDTT94bagsvOeFBecHShKqTZ6dm+q6MBAvabzas6l5FdivfZxJfwHTuxGBIaM+SLos7JymNcfU7E2V9oAdIMlWXKRJKzWhMRWOzCizYcomZk3wFGnqSR/3VZcJ+ZIEcLd16xA/z+7xVeAtjP3G3Duda9VoTH+QDdzuGVosKyV5DEsAOPYyXokw3w64l82pOB6xZy3GlpNj8haQ0vFF48KrBMfZ67TKDi5FKrrvcjYlPPuhxV2Y0CaPEIl6ou6ka7CLQXmgVzyIi0ETSytKarDkBR0ZlOZCGzsl/f7ijuBIvJg01lPFlbPFo/q85wAbJUC6pqxKsARCQUDGQN++DvLG+JYueFy2cxsH8VVmwSmV7GGB4ayA65/gISuow== gk@Grahams-MBP"
}

resource "aws_instance" "app_server" {
  ami           = "ami-084e8c05825742534"
  instance_type = "t2.micro"
  key_name      = "ec2_key"

  tags = {
    Name = "ExampleAppServerInstance"
    Project = "Catalyst"
  }
}
