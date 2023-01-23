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
