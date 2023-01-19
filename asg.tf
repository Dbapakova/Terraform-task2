
resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  launch_configuration = aws_launch_configuration.aws_conf.name
  vpc_zone_identifier       = aws_subnet.public_subnets.*.id
  
  lifecycle {
    create_before_destroy = true
  }
  target_group_arns                 = [aws_lb_target_group.lb_tg.arn]
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.lb_tg.arn
}