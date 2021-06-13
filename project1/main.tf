provider "aws" {
  region = "us-east-1"
  access_key = "AKIAJ6FZ7FPJEVTCPNSA"
  secret_key = "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"
}

# Variables
variable "subnet_prefix" {
  description = "cidr block for the subnet"
  type = string
  default = ""
}

# vpc
resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "production"
  }
}

# internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "production"
  }
}

# route table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "production"
  }
}

# subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.prod.id
  #cidr_block = "10.0.1.0/24"
  cidr_block = var.subnet_prefix
  availability_zone = "us-east-1a"

  tags = {
    Name = "production"
  }
}

# association route table.
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}

# security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow HTTP/S SSH inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production"
  }
}

# network interface
resource "aws_network_interface" "prod" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

# Elastic IP
resource "aws_eip" "prod" {
  vpc                       = true
  network_interface         = aws_network_interface.prod.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [ aws_internet_gateway.gw ]
}

# web server
resource "aws_instance" "web" {
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "aws-private-key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.prod.id
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update && sudo apt-get install -y apache2
    sudo systemctl start apache2
    #sudo bash -c "echo WEB SERVER > /var/www/html/index.html"
  EOF

  tags = {
    Name = "webserver"
  }
}

output "server_public_ip" {
  value = aws_eip.prod.public_ip
}