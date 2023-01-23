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

# resource "aws_subnet" "public_subnet_az1" {
#   availability_zone = data.aws_availability_zones.azs.names[0]
#   cidr_block        = "10.0.11.0/24"
#   vpc_id            = aws_vpc.vpc.id

#   tags = {
#     Name = "Public Subnet AZ1"
#     Project = "Catalyst"
#   }
# }

# resource "aws_subnet" "public_subnet_az2" {
#   availability_zone = data.aws_availability_zones.azs.names[1]
#   cidr_block        = "10.0.21.0/24"
#   vpc_id            = aws_vpc.vpc.id

#   tags = {
#     Name = "Public Subnet AZ2"
#     Project = "Catalyst"
#   }
# }

# resource "aws_subnet" "public_subnet_az3" {
#   availability_zone = data.aws_availability_zones.azs.names[2]
#   cidr_block        = "10.0.31.0/24"
#   vpc_id            = aws_vpc.vpc.id

#   tags = {
#     Name = "Public Subnet AZ3"
#     Project = "Catalyst"
#   }
# }
