variable table_name {}
variable table_partition_key {}
variable table_read_capacity {}
variable table_write_capacity {}
variable dynamo_billing_mode {}
variable table_attributes {
  type = list(object(
    {
      name = string
      type = string
    }
  ))
}
variable tags {}