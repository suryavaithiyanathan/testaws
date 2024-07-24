resource aws_efs_file_system main {
  count      = var.enabled ? 1 : 0
  encrypted  = true
  kms_key_id = var.kms_key_arn
  tags       = merge(var.tags)
}

resource aws_efs_mount_target main {
  count = length(var.subnet_ids)

  file_system_id = var.enabled ? aws_efs_file_system.main.*.id[0] : var.efs_file_system_id
  subnet_id      = var.subnet_ids[count.index]

  security_groups = [
    var.efs_security_group_id,
  ]
}
