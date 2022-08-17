output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "public_subnet_ids" {
  value = { for k, v in aws_subnet.public_subnet : v.tags.Name => v.id }
}

output "private_subnet_ids" {
  value = { for k, v in aws_subnet.private_subnet : v.tags.Name => v.id }
}


output "public_route_table_association" {
  value = { for k, v in aws_route_table_association.public_route_table_association : v.subnet_id => v.route_table_id }
}

output "private_route_table_association" {
  value = { for k, v in aws_route_table_association.private_route_table_association : v.subnet_id => v.route_table_id }
}

output "sg_web" {
  value = aws_security_group.web.id
}

output "sg_db_rds_postgres" {
  value = aws_security_group.db_rds_postgres.id
}

output "sg_load_balancer" {
  value = aws_security_group.load_balancer.id
}

output "alb" {
  value = aws_lb.alb.id
}




