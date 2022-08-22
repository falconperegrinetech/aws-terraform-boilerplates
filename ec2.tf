data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.instance_key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_launch_template" "launch_template" {
  name_prefix   = "${var.prefix}-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  user_data     = filebase64("ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.autoscaling.id]

  }
}
