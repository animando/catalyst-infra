terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "http" {
    address        = "https://api.tfstate.dev/github/v1"
    lock_address   = "https://api.tfstate.dev/github/v1/lock"
    unlock_address = "https://api.tfstate.dev/github/v1/lock"
    lock_method    = "PUT"
    unlock_method  = "DELETE"
    username       = "animando/catalyst-infra"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ec2_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvNrdxTkcW3yBvHbnuBNED4ug0wN6CKxHN5YbWrp78pT/rCaX7XrH78AhhQh223ELqqtincGQVfw3Ie3/zb9NuW5jdFSYx6zyxVuMGrhQsRE9lrVic/PdQ51zrc2ccgufNxFZSQPaf7+9D0vftwXKiESLuoPj5w63kPraF1uTxhZJN2N1atK4uvDadkc+VP5hiu86U20qyAX1hZSoJerzqsFQ6VKyUDYF5Gp/poWEsjcoWubjp9RO8HKFWogVKx4FkRZQr5IBgPPqTIeP19mMawz33grQIadCS/JzIJvTnp+AVopXMIxSz/dokd/Cg4i5pnMwaL2tl9qi8mnNVS/JfwMwjsZuDR3qK0DV6rCXzpHRJ2jl/QI9NayfpsUdIxadfNH7hH2ZRuNXV1VzJXh1biXInyk5Ne9WGjzLrWK0wJxcYpvATjiDFdN6r0U8V24aPtwdV0Wmebo3fQQmdIw8YrsAmn3uo3zbmtqn8+jD5TT2z//JjMVz+0To6UUCtskRKBb06eFcCRAoSygJKIRXKeS1Li/R5vh1GnHUS4zUhfj5dTItcrWpB+SOgPEO6I3kF0CfteNfN2kv/9VqOuVL2F8RoA7nDQiwk6Az6WlAuJft0wkmCXvyJITbu+iIat/RIQx7bAL2Edk7UYZiY00q2mEV1OKhTk5wGNy0ywFyflw=="
}

resource "aws_instance" "app_server" {
  ami           = "ami-084e8c05825742534"
  instance_type = "t2.micro"
  key_name      = "ssh_key"

  tags = {
    Name = "ExampleAppServerInstance"
    Project = "Catalyst"
  }
}
