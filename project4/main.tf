##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_vpc" "main" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = "true"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnets" {
  count                   = 2
  cidr_block              = var.subnets_address_space[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
}

resource "aws_route_table_association" "rtba" {
  count          = 2
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb.id
}


resource "aws_security_group" "elb-sg" {
  name   = "elb_sg"
  vpc_id = aws_vpc.main.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# LOAD BALANCER #
resource "aws_elb" "web" {
  name = "nginx-elb"

  #subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  subnets         = aws_subnet.subnets[*].id
  security_groups = [aws_security_group.elb-sg.id]
  instances       = [aws_instance.nginx1.id, aws_instance.nginx2.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.main.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.network_address_space]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx1" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  #subnet_id              = aws_subnet.subnet1.id
  subnet_id              = aws_subnet.subnets[0].id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update && sudo apt-get install -y nginx
    sudo systemctl start nginx
    echo '<html><head><title>Blue Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Blue Team</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "nginx2" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  #subnet_id              = aws_subnet.subnet2.id
  subnet_id              = aws_subnet.subnets[1].id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update && sudo apt-get install -y nginx
    sudo systemctl start nginx
    echo '<html><head><title>Green Team Server</title></head><body style=\"background-color:#77A032\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Green Team</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "webserver"
  }
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_elb_public_dns" {
  value = aws_elb.web.dns_name
}