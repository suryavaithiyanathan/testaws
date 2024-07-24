resource aws_lb_target_group alb_target_group {
  name     = "${var.tags["Name"]}-tg"
  port     = "443"
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.cookie_duration
    enabled         = true
  }

  tags = merge(var.tags)
}
