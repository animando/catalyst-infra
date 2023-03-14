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
