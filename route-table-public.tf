resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-public-route-table"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}
