resource aws_dynamodb_table table {
  name     = var.table_name
  hash_key = var.table_partition_key

  billing_mode   = var.dynamo_billing_mode
  read_capacity  = var.table_read_capacity
  write_capacity = var.table_write_capacity

  dynamic attribute {
    for_each = var.table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = merge(var.tags)
}