resource aws_lb_listener nlb_listener {
  count             = length(var.lb_configuration)
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.lb_configuration[count.index].listener_port
  protocol          = var.lb_configuration[count.index].listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.nlb_target_group[count.index].arn
    type             = "forward"
  }
}
