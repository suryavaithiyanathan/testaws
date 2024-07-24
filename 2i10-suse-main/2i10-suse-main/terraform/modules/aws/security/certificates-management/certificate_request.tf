resource tls_cert_request request {
  #key_algorithm   = tls_private_key.private_key.algorithm
  #key_algorithm    = "RSA"
  private_key_pem = tls_private_key.private_key.private_key_pem
  
  subject {
    #common_name         = format("%s%s%s%s", var.aspire_code, "-", var.application_name, ".airbus.corp")
    common_name         = "geasrte0"
    organization        = var.organization
    organizational_unit = var.organizational_unit
    locality            = var.locality
    province            = var.province
    country             = var.country
  }

  dns_names    = var.dns_names
  ip_addresses = var.ip_addresses
  uris         = var.uris
}

resource aws_s3_bucket_object request {
  key        = format("%s%s%s%s%s%s%s%s%s%s%s", "/", var.aspire_code, "-", var.application_name, "/", var.environment, "/certificate-requests/", var.aspire_code, "-", var.application_name, ".csr")
  bucket     = var.certificates_management_bucket_name
  content    = tls_cert_request.request.cert_request_pem
  kms_key_id = var.kms_key_id
}