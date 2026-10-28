data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.12.20261026.1-kernel-6.18-x86_64"]
  }

  owners = ["137112412989"]
}

resource "aws_key_pair" "keypair" {
  key_name   = "aws-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxyqzIikF6R/40k5vajUEymWpHesDonng7cZeGVmh+S"
}

resource "aws_instance" "lab-vm" {
  ami               = data.aws_ami.amazon_linux.id
  availability_zone = "us-east-1a"
  instance_type     = "t3.micro"
  #   primary_network_interface {
  #     network_interface_id = aws_network_interface.lab-if.id
  #   }

  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  subnet_id       = aws_subnet.lab-subnet.id
  key_name        = "aws-key"

  tags = {
    Name = "lab-vm"
  }
}


