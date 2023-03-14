resource "aws_security_group" "allow_all_egress" {
  name = "allow_all_egress"
  vpc_id = aws_vpc.vpc.id

  egress {
    description      = "HTTPS egress"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "HTTP egress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "All HTTP/S egress"
    Project = "Catalyst"
  }
}

resource "aws_security_group" "msk_security_group" {
  name = "msk_security_group"
  vpc_id = aws_vpc.vpc.id
  ingress {
    description      = "MSK ingress"
    from_port        = 9098
    to_port          = 9098
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }

  egress {
    description      = "MSK egress"
    from_port        = 9098
    to_port          = 9098
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }

  tags = {
    Name = "Allow MSK ingress/egress"
    Project = "Catalyst"
  }
}

resource "aws_security_group" "lambda_security_group" {
  name        = "lambda_security_group"
  vpc_id = aws_vpc.vpc.id

  egress {
    description      = "MSK egress"
    from_port        = 9098
    to_port          = 9098
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }
  egress {
    description      = "SSL egress to anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSL ingress"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }

  tags = {
    Name = "Lambda security group"
    Project = "Catalyst"
  }
}

resource "aws_security_group" "ec2_ssh" {
  name        = "ec2_ssh"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description      = "SSH from office"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["82.44.227.213/32"]
  }

  tags = {
    Name = "Allow EC2 SSH ingress"
    Project = "Catalyst"
  }
}

resource "aws_security_group" "allow_vpc_https_traffic" {
  name        = "allow_vpc_https_traffic"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description      = "SSL from anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "SSL to anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow VPC HTTPs traffic"
    Project = "Catalyst"
  }
}
