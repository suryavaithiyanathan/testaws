output efs_file_system_id {
  value = length(aws_efs_file_system.main.*.id) > 0 ? aws_efs_file_system.main.*.id[0] : ""
}
