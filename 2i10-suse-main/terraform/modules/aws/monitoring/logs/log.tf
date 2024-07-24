resource aws_cloudwatch_log_group logs_groups {
  name              = "/airbus/SAP-M2C/${var.aspire_code}-${var.application_name}-${var.sid}/${var.environment}-${var.type}-logs"
  retention_in_days = var.logs_retention
  kms_key_id        = var.kms_key_arn
  tags              = merge(var.tags)
}