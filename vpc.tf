resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Project = "Catalyst"
  }
}

# resource "aws_eip" "eip" {
#   vpc      = true
# }

resource "aws_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "public_subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.11.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Project = "Catalyst"
  }
}

resource "aws_route_table_association" "public_1_route_table" {
  subnet_id = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.igw_route_table.id
}

# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public_subnet_az1.id

#   tags = {
#     Project = "Catalyst"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.igw]
# }
