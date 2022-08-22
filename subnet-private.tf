resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-private-subnet-${var.private_subnets[count.index]}"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}
