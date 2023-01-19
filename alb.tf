resource "aws_lb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  internal = false
  subnets            = aws_subnet.public_subnets.*.id
  security_groups    = [aws_security_group.web_sg.id]
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "alb"
  }
}
resource "aws_lb_target_group" "lb_tg" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}