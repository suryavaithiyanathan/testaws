# EC2 Instance Profile
resource aws_iam_instance_profile ec2_instance_profile {
  count = var.enabled ? 1 : 0
  #name  = var.tags["ApplicationComponent"] == "sap-router" || var.tags["ApplicationComponent"] == "sap-webdispatcher" ? "${var.tags["ApplicationName"]}_ec2-instance-profile" : "${var.tags["ApplicationName"]}-${var.tags["ApplicationComponent"]}-${var.tags["Sid"]}_ec2-instance-profile"
  name = var.tags["ComponentFunction"] == "sap-router" || var.tags["ComponentFunction"] == "sap-webdispatcher" ? "${var.tags["ApplicationName"]}_ec2-instance-profile" : "${var.tags["ApplicationName"]}-${var.tags["ComponentFunction"]}-${var.tags["Sid"]}_ec2-instance-profile"
  role  = var.iam_role
}