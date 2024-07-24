resource aws_iam_role iam_role {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  tags               = merge(var.tags)
}

resource aws_iam_role_policy_attachment iam_role {
  role = aws_iam_role.iam_role.name

  policy_arn = aws_iam_policy.iam_policy.arn
}

resource aws_iam_role_policy_attachment aws_managed_role {
  count = length(var.aws_managed_policies)

  role       = aws_iam_role.iam_role.name
  policy_arn = var.aws_managed_policies[count.index]
}
