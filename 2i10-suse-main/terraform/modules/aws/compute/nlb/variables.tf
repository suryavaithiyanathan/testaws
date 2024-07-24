variable internal {}
variable enable_cross_zone_load_balancing {}
variable lb_configuration {
  type = list(
    object(
      { listener_protocol   = string,
        listener_port       = string,
        inbound_subnets     = list(string),
        target_protocol     = string,
        target_port         = string,
        target_vpc_id       = string,
        target_instance_ids = list(string),
        target_subnets      = list(string)
      }
    )
  )
}
variable enabled {
  default = false
}
variable target_type {
  default = "instance"
}
#variable sid {}
variable tags {}
variable enable_deletion_protection {}