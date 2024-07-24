variable bucket_name {}
variable policy { default = "" }
variable kms_key_arn {}
variable versioning { default = false }
variable lifecycle_rules {
  type = list(object({
    prefix  = string
    enabled = bool
    transitions = list(object({
      days          = number
      storage_class = string
    }))
    expiration = object({
      days = number
    })
  }))
  default = []
}
variable noncurrent_version_lifecycle_rules {
  type = list(object({
    prefix  = string
    enabled = bool
    transitions = list(object({
      days          = number
      storage_class = string
    }))
    expiration = object({
      days = number
    })
  }))
  default = []
}
variable tags {}
variable attach_policy { default = false }