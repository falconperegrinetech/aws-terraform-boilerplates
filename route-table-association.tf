resource "aws_route_table_association" "public_subnets_route_table_association" {
  for_each       = { for k, v in aws_subnet.public_subnet : v.tags.Name => v.id }
  subnet_id      = each.value
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_subnets_route_table_association" {
  for_each       = { for k, v in aws_subnet.private_subnet : v.tags.Name => v.id }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table.id
}
