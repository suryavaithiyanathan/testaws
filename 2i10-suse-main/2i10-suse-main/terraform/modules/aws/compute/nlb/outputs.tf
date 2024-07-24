output nlb_target_group_arn {
  value = aws_lb_target_group.nlb_target_group.*.arn
}
output nlb_name {
  value = aws_lb.nlb.*.tags.Name
}
output nlb_dns_name {
  value = aws_lb.nlb.*.dns_name
}
output nlb_zone_id {
  value = aws_lb.nlb.*.zone_id
}