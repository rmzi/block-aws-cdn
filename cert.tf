resource "aws_acm_certificate" "this" {
  domain_name               = local.main_subdomain
  validation_method         = "DNS"
  subject_alternative_names = local.alt_subdomains

  tags = {
    Stack       = var.stack_name
    Environment = var.env
    Block       = var.block_name
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = aws_acm_certificate.this.domain_validation_options

  name            = each.value["resource_record_name"]
  type            = "CNAME"
  allow_overwrite = true
  zone_id         = data.terraform_remote_state.domain.outputs.zone_id
  records         = [each.value["resource_record_value"]]
  ttl             = 60
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
