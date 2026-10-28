resource "aws_vpc" "lab-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lab-vpc"
  }
}

resource "aws_subnet" "lab-subnet" {
  vpc_id                  = aws_vpc.lab-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.aws_az
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-subnet"
  }
}

resource "aws_internet_gateway" "lab-gw" {
  vpc_id = aws_vpc.lab-vpc.id


  tags = {
    Name = "lab-gw"
  }
}

resource "aws_route_table" "lab-rt" {
  vpc_id = aws_vpc.lab-vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab-gw.id

    # network_interface_id = aws_network_interface.lab-if.id
  }

  tags = {
    Name = "lab-rt"
  }
}

resource "aws_route_table_association" "lab-rt-assoc" {
  subnet_id      = aws_subnet.lab-subnet.id
  route_table_id = aws_route_table.lab-rt.id
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Permite trafego na porta 22"
  vpc_id      = aws_vpc.lab-vpc.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"] # pegando o ip do usuario
  }
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

