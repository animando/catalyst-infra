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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDb/4y2rih1EZnjH0OzvI+p8e5CkKmI0o+M+buVSqdOY9XSwQI7oZAbPU/1AwWJ85YR5NfCd2/Rx2ZWOUW+EM2JqL4lhCruoNSPMTdiJnYvkI1h3jgCLUHhDOykvbqBFQUWPdOg3yZzlFh7nzfz/uiDtgwVGobSy5mWSi4u6aXOQdGiIRwf9xn/GMhh+Cd1BarYMWu3+mt3uQ7pFHokfGiUsyimXMJbk3tIC5OMrLhLsjZzxI3j+lOmK/gjC/Yvx4OtbplecK9yZHauafpAbFCsirl+OYWRtRQ7jKOauNp0GbPpNhyP9Cos+z15UdhHPOp+hG0QM5cxPWJo3/rBmfluMAq1OxJZTYT7Aimit7BVu7PFMIu71nBLAP/1Awfusq1/oi8BpGoUF5q2Z/vAGnYYUQ/TJHLyJXIsgzn+nAYFrtvHs2ytHu+wrRUDQ6Vv1WbVHvfj96Z96saduqkKzdGZdFaXoUWg3bEzIW+iHzEufGhqY2ogNj0sOFuMUK6/+g43oDSmp5FdbV6VPd1TZ8q4FQ5/3n33sIlh2YDLCLhUFEw11zr/vm2gHX3PB+nydKPc8N3Q34mKi4pRd6PYDM+FqEWQTmnhDgmcDSAYhxZiV1goOeWw85pmfC9/XN5qa1Z2TyFmKMmAJHwomh3/+qTCB75Ar6ZROA12OiEH14B67w== gk@Grahams-MBP"
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
