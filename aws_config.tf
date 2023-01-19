data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "aws_conf" {
  name_prefix                 = "web-"
  image_id                    = data.aws_ami.amazon_ami.id
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = file("install_httpd.sh")
  
  lifecycle {
    create_before_destroy = true
  }
}