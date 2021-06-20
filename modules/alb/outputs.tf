output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "lb_target_group_arns" {
  value = aws_lb_target_group.this.*.arn
}
