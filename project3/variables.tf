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