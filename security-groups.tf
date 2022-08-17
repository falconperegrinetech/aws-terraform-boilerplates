resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.vpc.id
  name        = "WEB"
  description = "Allow incoming connections to port 80 and 443 from anywhere"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet[0].cidr_block]
  }

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-web-security-group"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

resource "aws_security_group" "db_rds_postgres" {
  vpc_id      = aws_vpc.vpc.id
  name        = "DB_RDS_POSTGRES"
  description = "Allow incoming connections to port 5432"


  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-db-rds-postgres-security-group"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}
