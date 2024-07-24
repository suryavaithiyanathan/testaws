# Private Key Variables
variable algorithm {}
variable rsa_bits {}
variable ecdsa_curve { default = "P256" }
# Certificate Signature Request Variables
variable organization {}
variable organizational_unit {}
variable locality {}
variable province {}
variable country {}
variable dns_names { default = [] }
variable ip_addresses { default = [] }
variable uris { default = [] }
variable certificates_management_bucket_name {}
variable kms_key_id {}
variable aspire_code {}
variable environment {}
variable application_name {}