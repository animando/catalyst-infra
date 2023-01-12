resource "aws_key_pair" "catalyst" {
  key_name   = "catalyst"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNMNqsHVVa2a42bNGFT7OzzZMHEsFcuokPzkyMz1rYOls2kKMFlII7s+32d+GvNUokUTP0XM/KQFdcZh+mtU1fj6ZCmoPG9owzrwyUEyybtsjMqQE6zUP7vBM1VB02d7kYsmxRT2N39wNqfDxfXq1N8e3BZ1+QVmf4yGn1uB9f74DVhm8ZuHfa0F73RsAaFJsMuUhQoNRFleE17c10pvTpDtVtda2S8FAPqtjiP1KOC7ar935Ze0DLNsxrw2OwD+dx0m9O4PRIS8ZgSYwJ2wwDNivjXbW8RYLGcRVefF7loKh4Xw1yVh/sMRLe7nUVMFlEi2gc9T8/VKwWiylfc4BuKoY8Qq3OrLm0cxOiJ0Xok2n7oaUpkoz+GR0/nkfWyaQQHecDsipAcmj6/tjcQ9olb0xt58VxJ7r5kxwHhxaBrMkwnTy1aw7FuGmJP82tVvX7flIuA938Bu+kA9x54RDM9pFgs4tOmt6hv+GDTflAeEPrejLnbAfYM3ZLuX07haU= gk@Grahams-MBP"
}

resource "aws_instance" "bastion" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  key_name        = "catalyst"

  subnet_id = aws_subnet.subnet_az1
  vpc_security_group_ids = [
    aws_security_group.msk_security_group.id,
    aws_security_group.allow_all_egress,
    ec2_ssh
  ]

  tags = {
    Name = "Bastion"
    Project = "Catalyst"
  }
}
