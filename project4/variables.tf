##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "key_name" {}

variable "region" {
  default = "us-east-1"
}

variable "instance_ami" {
  default = "ami-03d315ad33b9d49c4"
}

variable "network_address_space" {
  default = "10.1.0.0/16"
}

variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}

variable "subnet2_address_space" {
  default = "10.1.1.0/24"
}

variable "subnets_address_space" {
  type    = list(any)
  default = ["10.1.0.0/24", "10.1.1.0/24"]
}