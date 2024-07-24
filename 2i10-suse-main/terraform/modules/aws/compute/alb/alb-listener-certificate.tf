# resource aws_acm_certificate alb_listener_certificate {
#   domain_name               = var.private_zone_name
#   validation_method         = "DNS"

#   # subject_alternative_names = var.subject_alternative_names
#   # validation_method         = var.validation_method

#   # options {
#   #   certificate_transparency_logging_preference = var.certificate_transparency_logging_preference ? "ENABLED" : "DISABLED"
#   # }

#   tags = merge(var.tags)

#   lifecycle {
#     create_before_destroy = true
#   }
# }