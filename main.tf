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

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"

  ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Catalyst"
  }
}


resource "aws_key_pair" "catalyst2" {
  key_name   = "catalyst2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNMNqsHVVa2a42bNGFT7OzzZMHEsFcuokPzkyMz1rYOls2kKMFlII7s+32d+GvNUokUTP0XM/KQFdcZh+mtU1fj6ZCmoPG9owzrwyUEyybtsjMqQE6zUP7vBM1VB02d7kYsmxRT2N39wNqfDxfXq1N8e3BZ1+QVmf4yGn1uB9f74DVhm8ZuHfa0F73RsAaFJsMuUhQoNRFleE17c10pvTpDtVtda2S8FAPqtjiP1KOC7ar935Ze0DLNsxrw2OwD+dx0m9O4PRIS8ZgSYwJ2wwDNivjXbW8RYLGcRVefF7loKh4Xw1yVh/sMRLe7nUVMFlEi2gc9T8/VKwWiylfc4BuKoY8Qq3OrLm0cxOiJ0Xok2n7oaUpkoz+GR0/nkfWyaQQHecDsipAcmj6/tjcQ9olb0xt58VxJ7r5kxwHhxaBrMkwnTy1aw7FuGmJP82tVvX7flIuA938Bu+kA9x54RDM9pFgs4tOmt6hv+GDTflAeEPrejLnbAfYM3ZLuX07haU= gk@Grahams-MBP"
}

resource "aws_instance" "app_server" {
  ami            = "ami-084e8c05825742534"
  instance_type  = "t2.micro"
  key_name       = "catalyst2"
  security_gorup = "ec2_sg"

  tags = {
    Name = "ExampleAppServerInstance"
    Project = "Catalyst"
  }
}
