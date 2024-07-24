resource random_password generated_password {
  length      = var.password_length
  special     = var.enable_special_chars
  count       = var.is_password ? 1 : 0
  min_numeric = 1
}

resource aws_ssm_parameter parameter {
  name        = "/generic_secret/aws/${lower(var.aspire_code)}/${lower(var.environment)}/${lower(var.sid)}/${lower(var.aws_service)}/${lower(replace(var.parameter_short_description, " ", "-"))}"
  description = "${var.parameter_short_description} for ${var.application_name} - ${var.environment} - ${var.sid}"
  type        = "SecureString"
  value       = var.is_password ? random_password.generated_password[0].result : var.value
  key_id      = var.kms_key_arn
  tags        = merge(var.tags)
}