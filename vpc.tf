resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"        = var.prefix
    "Description" = "Falcon Boilerplate VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name"        = "vpc-boilerplate-internet-gateway"
    "Description" = "Falcon Boilerplate VPC Internet Gateway"
  }
}

