variable "internal" {}
variable "enable_cross_zone_load_balancing" {}
variable "alb_configuration" {
  type = object(
    { airbus_cidr_blocks  = list(string),
      subnet_ids          = list(string),
      target_instance_ids = list(string)
    }
  )
}
variable "private_zone_name" {}
variable "enabled" { default = false }
variable "tags" {}
variable "alb_certificate_arn" {}
variable "enable_deletion_protection" {}
variable "vpc_id" {}
variable "cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds)"
  default     = "86400"
}
