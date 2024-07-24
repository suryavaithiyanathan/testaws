resource aws_s3_bucket_policy policy {
  count  = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = var.policy
}