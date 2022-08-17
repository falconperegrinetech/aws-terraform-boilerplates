resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-vpc"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-igw"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

