output alb_target_group_arn {
  value = aws_lb_target_group.alb_target_group.*.arn
}
output alb_name {
  value = aws_lb.alb.tags.Name
}
output alb_dns_name {
  value = aws_lb.alb.dns_name
}
# output alb_listener_certificate_arn {
#   value = aws_acm_certificate.alb_listener_certificate.arn
# }


