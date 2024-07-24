resource aws_route53_record record {
  count   = length(var.record_names)
  zone_id = var.zone_id
  name    = var.record_names[count.index]
  type    = var.record_type
  ttl     = var.record_ttl
  records = [var.records[count.index]]
}
