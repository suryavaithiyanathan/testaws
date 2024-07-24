resource aws_lb_target_group nlb_target_group {
  count    = length(var.lb_configuration)
  #name     = var.tags["ApplicationComponent"] == "sap-router" || var.tags["ApplicationComponent"] == "web-dispatcher" || var.tags["ApplicationComponent"] == "" ? "${var.tags["ApplicationName"]}-${var.tags["Sid"]}-tg-${count.index}" : "${var.tags["ApplicationName"]}-${var.tags["ApplicationComponent"]}-${var.tags["Sid"]}-tg-${count.index}"
  name = var.tags["ComponentFunction"] == "sap-router" || var.tags["ComponentFunction"] == "web-dispatcher" || var.tags["ComponentFunction"] == "" ? "${var.tags["ApplicationName"]}-${var.tags["Sid"]}-tg-${count.index}" : "${var.tags["ApplicationName"]}-${var.tags["ComponentFunction"]}-${var.tags["Sid"]}-tg-${count.index}"
  port     = var.lb_configuration[count.index].target_port
  protocol = var.lb_configuration[count.index].target_protocol
  vpc_id   = var.lb_configuration[count.index].target_vpc_id
  target_type = var.target_type 
  tags = merge(var.tags)
}
