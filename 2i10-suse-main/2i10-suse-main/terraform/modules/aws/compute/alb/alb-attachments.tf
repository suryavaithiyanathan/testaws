resource aws_lb_target_group_attachment alb_attachment {
  count = length(var.alb_configuration.target_instance_ids)

  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.alb_configuration.target_instance_ids[count.index]

}