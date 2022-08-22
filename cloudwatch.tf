resource "aws_cloudwatch_metric_alarm" "up" {
  alarm_name          = "ASG Up"
  alarm_description   = "Scales up when CPU utilization is above 70%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaleup.arn]


  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-scale-up-alarm"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}


resource "aws_cloudwatch_metric_alarm" "down" {
  alarm_name          = "ASG Down"
  alarm_description   = "Scales donw when CPU utilization is lesser 40%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 40

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaledown.arn]

  tags = merge(local.common_tags, {
    "Name"        = "${var.prefix}-scale-down-alarm"
    "Description" = "Falcon Terraform AWS Boilerplates"
  })
}

