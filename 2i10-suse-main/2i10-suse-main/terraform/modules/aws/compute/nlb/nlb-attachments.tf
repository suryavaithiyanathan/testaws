resource aws_lb_target_group_attachment nlb_attachment {
  count = length(var.lb_configuration[*].target_instance_ids)

  target_group_arn = aws_lb_target_group.nlb_target_group[floor(count.index / length(var.lb_configuration[0].target_instance_ids))].arn
  target_id        = var.lb_configuration[floor(count.index / length(var.lb_configuration[0].target_instance_ids))].target_instance_ids[count.index % length(var.lb_configuration[0].target_instance_ids)]

}