output availability_zone {
  value = aws_instance.linux-server.*.availability_zone
}
output private_ip {
  value = aws_instance.linux-server.*.private_ip
}
output instance_id {
  value = aws_instance.linux-server.*.id
}
output instance_name {
  value = aws_instance.linux-server.*.tags.Name
}
output instance_profile {
  value = length(aws_iam_instance_profile.ec2_instance_profile.*.name) > 0 ? aws_iam_instance_profile.ec2_instance_profile.*.name[0] : ""
}