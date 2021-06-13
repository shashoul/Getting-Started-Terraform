provider "aws" {
  region = var.region
  access_key = "AKIAJ6FZ7FPJEVTCPNSA"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  count = length(data.aws_availability_zones.azs.names)
  vpc_id     = aws_vpc.main.id
  # cidr_block = var.subnets_cidr[count.index]
  cidr_block = element(var.subnets_cidr, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "Main-${count.index+1}"
  }
}