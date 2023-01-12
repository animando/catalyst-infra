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

  tags = {
    Project = "Catalyst"
  }
}

resource "aws_security_group" "ec2_ssh" {
  name        = "ec2_ssh"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Catalyst"
  }
}
