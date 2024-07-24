resource aws_cloudwatch_metric_alarm auto_recovery_alarm {
  count               = var.instance_count
  alarm_name          = "EC2AutoRecover-${aws_instance.linux-server[count.index].id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Minimum"

  dimensions = {
    InstanceId = aws_instance.linux-server[count.index].id
  }

  alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]
  //todo add an SNS topic and in order to handle the notifications
  threshold         = "1"
  alarm_description = "Auto recover the EC2 instance if Status Check fails."
  tags              = merge(var.tags)
}