resource "aws_lb" "alb" {
  name               = "alb-${var.prefix}"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]
  internal           = false
  load_balancer_type = "application"

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-application-load-balancer"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group-${var.prefix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    interval            = 60
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-target-group"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }


  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-alb-listener-group"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}
