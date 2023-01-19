output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "DNS name of ALB"
}
output "route53_record_name" {
  value       = aws_route53_record.www.name
  description = "Route53 DNS record"
}