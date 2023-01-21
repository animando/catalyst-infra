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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Catalyst Internet Gateway"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Private Subnet AZ1"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Private Subnet AZ2"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Private Subnet AZ3"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "public_subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.11.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Public Subnet AZ1"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.21.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Public Subnet AZ2"
    Project = "Catalyst"
  }
}

resource "aws_subnet" "public_subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.31.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "Public Subnet AZ3"
    Project = "Catalyst"
  }
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Internet Gateway Route Table"
    Project = "Catalyst"
  }
}

resource "aws_route_table_association" "public_route_table_az1" {
  subnet_id = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_route_table_az2" {
  subnet_id = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_route_table_az3" {
  subnet_id = aws_subnet.public_subnet_az3.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_vpc_endpoint" "lambda_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.lambda"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.subnet_az1.id,
    aws_subnet.subnet_az2.id,
    aws_subnet.subnet_az3.id
  ]

  security_group_ids = [
    aws_security_group.allow_vpc_https_traffic.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "Lambda VPC Endpoint"
    Project = "Catalyst"
  }
}

resource "aws_vpc_endpoint" "sns_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.sns"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.subnet_az1.id,
    aws_subnet.subnet_az2.id,
    aws_subnet.subnet_az3.id
  ]

  security_group_ids = [
    aws_security_group.allow_vpc_https_traffic.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "SNS VPC Endpoint"
    Project = "Catalyst"
  }
}

resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  vpc_endpoint_type = "Gateway"
  service_name = "com.amazonaws.eu-west-2.dynamodb"

  route_table_ids = [
    aws_vpc.vpc.default_route_table_id,
    aws_route_table.private_route_table_az1.id,
    aws_route_table.private_route_table_az2.id,
    aws_route_table.private_route_table_az3.id
  ]

  tags = {
    Name = "DynamoDb VPC Endpoint"
    Project = "Catalyst"
  }
}

resource "aws_vpc_endpoint" "sts_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.sts"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.subnet_az1.id,
    aws_subnet.subnet_az2.id,
    aws_subnet.subnet_az3.id
  ]

  security_group_ids = [
    aws_security_group.allow_vpc_https_traffic.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "STS VPC Endpoint"
    Project = "Catalyst"
  }
}

resource "aws_vpc_endpoint" "execute-api_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.execute-api"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.subnet_az1.id,
    aws_subnet.subnet_az2.id,
    aws_subnet.subnet_az3.id
  ]

  security_group_ids = [
    aws_security_group.allow_vpc_https_traffic.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "Execute API VPC Endpoint"
    Project = "Catalyst"
  }
}

resource "aws_vpc_endpoint" "secretsmanager_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.secretsmanager"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.subnet_az1.id,
    aws_subnet.subnet_az2.id,
    aws_subnet.subnet_az3.id
  ]

  security_group_ids = [
    aws_security_group.allow_vpc_https_traffic.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "Secrets Manager VPC Endpoint"
    Project = "Catalyst"
  }
}

#
resource "aws_eip" "eip_az1" {
  vpc = true

  tags = {
    Name = "Elastic IP 1"
    Project = "Catalyst"
  }
}

resource "aws_eip" "eip_az2" {
  vpc = true

  tags = {
    Name = "Elastic IP 2"
    Project = "Catalyst"
  }
}

resource "aws_eip" "eip_az3" {
  vpc = true

  tags = {
    Name = "Elastic IP 3"
    Project = "Catalyst"
  }
}


resource "aws_nat_gateway" "public_nat_gateway_az1" {
  allocation_id = aws_eip.eip_az1.id
  subnet_id = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "Catalyst Nat Gateway AZ1"
    Project = "Catalyst"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_nat_gateway" "public_nat_gateway_az2" {
  allocation_id = aws_eip.eip_az2.id
  subnet_id = aws_subnet.public_subnet_az2.id

  tags = {
    Name = "Catalyst Nat Gateway AZ2"
    Project = "Catalyst"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_nat_gateway" "public_nat_gateway_az3" {
  allocation_id = aws_eip.eip_az3.id
  subnet_id = aws_subnet.public_subnet_az3.id

  tags = {
    Name = "Catalyst Nat Gateway AZ3"
    Project = "Catalyst"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway_az1.id
  }

  tags = {
    Name = "Private Route Table AZ1"
    Project = "Catalyst"
  }
}

resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway_az2.id
  }

  tags = {
    Name = "Private Route Table AZ2"
    Project = "Catalyst"
  }
}

resource "aws_route_table" "private_route_table_az3" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway_az3.id
  }

  tags = {
    Name = "Private Route Table AZ3"
    Project = "Catalyst"
  }
}

resource "aws_route_table_association" "private_route_table_assoc_az1" {
  subnet_id = aws_subnet.subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table_association" "private_route_table_assoc_az2" {
  subnet_id = aws_subnet.subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

resource "aws_route_table_association" "private_route_table_assoc_az3" {
  subnet_id = aws_subnet.subnet_az3.id
  route_table_id = aws_route_table.private_route_table_az3.id
}
