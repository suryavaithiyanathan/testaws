resource  "aws_ssm_document" "document" {
  name            = var.command_name
  document_type   = var.automation_type
  document_format = "YAML"
  content         = var.path_to_yaml
  tags            = merge(var.tags)
}