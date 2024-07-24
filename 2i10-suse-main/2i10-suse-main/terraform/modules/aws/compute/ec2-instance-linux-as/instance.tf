resource aws_instance linux-server {
  ami                    = var.ami
  count                  = var.instance_count
  instance_type          = var.instance_type
  subnet_id              = flatten(var.subnet_ids)[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data
  ebs_optimized          = var.ebs_optimized
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.*.name[0]
  monitoring             = true
  key_name               = var.key_name

  lifecycle {
    ignore_changes = [user_data, root_block_device, ami]
  }

  tags = merge(var.tags, count.index == 0 ?
    tomap({"Name"= "${var.tags["Name"]}-aas", "Hostname"= var.hostnames[0]}) : tomap({"Name"= "${var.tags["Name"]}-aas${count.index + 1}", "Hostname"= var.hostnames[count.index]}))

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.volume_type
    encrypted   = true
    kms_key_id  = var.kms_key_arn
  }
}