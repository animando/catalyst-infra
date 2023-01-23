resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Catalyst Internet Gateway"
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
