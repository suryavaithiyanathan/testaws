output private_key_pem {
  value = tls_private_key.private_key.private_key_pem
}
output cert_request_pem {
  value = tls_cert_request.request.cert_request_pem
}