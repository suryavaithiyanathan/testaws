resource aws_lb nlb {
  name                             = var.tags["Name"]
  internal                         = var.internal
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  subnets                    = flatten(var.lb_configuration[*].inbound_subnets)
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(var.tags)
}