resource aws_cloudwatch_event_rule rule {
  name                = var.name
  description         = var.description
  schedule_expression = var.schedule_expression
  is_enabled          = var.is_enabled
}