resource aws_s3_bucket bucket {
  bucket = var.bucket_name
  acl    = "private"
  tags   = merge(var.tags)
  versioning {
    enabled = var.versioning
  }

  dynamic lifecycle_rule {
    for_each = var.lifecycle_rules
    content {
      prefix  = lifecycle_rule.value.prefix
      enabled = true

      dynamic transition {
        for_each = lifecycle_rule.value.transitions
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }
      expiration {
        days = lifecycle_rule.value.expiration.days
      }

    }
  }

  dynamic lifecycle_rule {
    for_each = var.noncurrent_version_lifecycle_rules
    content {
      prefix  = lifecycle_rule.value.prefix
      enabled = true

      dynamic noncurrent_version_transition {
        for_each = lifecycle_rule.value.transitions
        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
      noncurrent_version_expiration {
        days = lifecycle_rule.value.expiration.days
      }

    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}