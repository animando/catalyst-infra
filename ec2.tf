resource "aws_key_pair" "catalyst" {
  key_name   = "catalyst"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNMNqsHVVa2a42bNGFT7OzzZMHEsFcuokPzkyMz1rYOls2kKMFlII7s+32d+GvNUokUTP0XM/KQFdcZh+mtU1fj6ZCmoPG9owzrwyUEyybtsjMqQE6zUP7vBM1VB02d7kYsmxRT2N39wNqfDxfXq1N8e3BZ1+QVmf4yGn1uB9f74DVhm8ZuHfa0F73RsAaFJsMuUhQoNRFleE17c10pvTpDtVtda2S8FAPqtjiP1KOC7ar935Ze0DLNsxrw2OwD+dx0m9O4PRIS8ZgSYwJ2wwDNivjXbW8RYLGcRVefF7loKh4Xw1yVh/sMRLe7nUVMFlEi2gc9T8/VKwWiylfc4BuKoY8Qq3OrLm0cxOiJ0Xok2n7oaUpkoz+GR0/nkfWyaQQHecDsipAcmj6/tjcQ9olb0xt58VxJ7r5kxwHhxaBrMkwnTy1aw7FuGmJP82tVvX7flIuA938Bu+kA9x54RDM9pFgs4tOmt6hv+GDTflAeEPrejLnbAfYM3ZLuX07haU= gk@Grahams-MBP"
}

resource "aws_iam_instance_profile" "bastion_iam_profile" {
  name = "bastion-iam-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "bastion_role" {
  name = "bastion_role"
  path = "/"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
  ]

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_instance" "bastion" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  key_name        = "catalyst"

  subnet_id = aws_subnet.public_subnet_az1.id
  
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.msk_security_group.id,
    aws_security_group.allow_all_egress.id,
    aws_security_group.ec2_ssh.id
  ]

  iam_instance_profile = aws_iam_instance_profile.bastion_iam_profile.id

  tags = {
    Name = "Bastion"
    Project = "Catalyst"
  }
}
