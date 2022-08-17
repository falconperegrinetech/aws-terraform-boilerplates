resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-public-subnet-${var.public_subnets[count.index]}"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}


