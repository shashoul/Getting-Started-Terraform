variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "190.160.0.0/16"
}

variable "subnets_cidr" {
  default = ["190.160.1.0/24","190.160.2.0/24","190.160.3.0/24","190.160.4.0/24","190.160.5.0/24","190.160.6.0/24"]
}

# Declare data source
data "aws_availability_zones" "azs" {
}