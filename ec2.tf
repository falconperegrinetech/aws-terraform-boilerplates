data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_launch_template" "launch_template" {
  name_prefix   = "${var.prefix}-"
  image_id      = aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.instance_key_name
  user_data     = filebase64("ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    device_index                = 0
    security_groups             = [aws_security_group.autoscaling.id]
    delete_on_termination       = true
  }
}
