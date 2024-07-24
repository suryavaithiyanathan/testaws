variable ami {}
variable instance_type {}
variable vpc_security_group_ids {}
variable instance_count {}
variable subnet_ids {}
variable root_volume_size {}
variable user_data {}
variable ebs_optimized {}
variable volume_type {
  default = "gp2"
}
variable iam_role {}
variable enabled {
  default = false
}
variable tags {}
variable hostnames {}
variable kms_key_arn {}
variable key_name {}