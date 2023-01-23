resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "Catalyst VPC"
    Project = "Catalyst"
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}
