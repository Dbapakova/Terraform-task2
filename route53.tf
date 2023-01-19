resource "aws_route53_record" "www" {
  zone_id = "Z067613011H9H4GK9ZEG7"
  name    = "www.awsdatasystem.com"
  type    = "CNAME"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}