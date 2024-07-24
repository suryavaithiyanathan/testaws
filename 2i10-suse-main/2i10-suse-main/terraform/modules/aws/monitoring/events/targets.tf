resource aws_cloudwatch_event_target target {
  target_id = aws_cloudwatch_event_rule.rule.id
  arn       = var.document_arn
  rule      = aws_cloudwatch_event_rule.rule.name
  role_arn  = var.automations_role_arn
  input     = var.input
}