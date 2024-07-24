resource aws_security_group alb_sg {
  name   = "${var.tags["Name"]}-sg"
  vpc_id = var.vpc_id

  lifecycle {
    ignore_changes        = [description]
    create_before_destroy = true
  }
}

resource aws_security_group_rule alb_https_in {

  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = var.alb_configuration.airbus_cidr_blocks
}