resource aws_iam_policy iam_policy {
  name   = var.policy_name
  path   = "/${var.tags["AspireCode"]}/"
  policy = var.policy
}
