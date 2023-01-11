resource "aws_security_group" "msk_security_group" {
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