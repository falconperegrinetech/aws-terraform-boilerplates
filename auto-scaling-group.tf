resource "aws_autoscaling_group" "autoscaling" {
  name                = "${var.prefix}-autoscaling"
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]

  health_check_grace_period = 240
  health_check_type         = "ELB"
  force_delete              = true

  target_group_arns = [aws_lb_target_group.alb_target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "Scale Up"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  cooldown               = 180
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "Scale Up"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  cooldown               = 180
  policy_type            = "SimpleScaling"
}

