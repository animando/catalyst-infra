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

# resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
#   vpc_id = aws_vpc.vpc.id
#   vpc_endpoint_type = "Gateway"
#   service_name = "com.amazonaws.eu-west-2.dynamodb"

#   route_table_ids = [
#     aws_vpc.vpc.default_route_table_id,
#     aws_route_table.private_route_table_az1.id,
#     aws_route_table.private_route_table_az2.id,
#     aws_route_table.private_route_table_az3.id
#   ]

#   tags = {
#     Name = "DynamoDb VPC Endpoint"
#     Project = "Catalyst"
#   }
# }

resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.eu-west-2.dynamodb"
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
