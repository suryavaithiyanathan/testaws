resource aws_lb alb {
  name                             = var.tags["Name"]
  internal                         = var.internal
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_sg.id]
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  subnets                          = var.alb_configuration.subnet_ids
  enable_deletion_protection       = var.enable_deletion_protection
  tags = merge(var.tags)
}