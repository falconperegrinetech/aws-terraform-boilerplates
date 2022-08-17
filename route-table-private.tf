resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-private-route-table"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}
