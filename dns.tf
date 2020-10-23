resource "aws_route53_record" "this" {
  provider = aws.domain

  zone_id = data.terraform_remote_state.domain.outputs.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  provider = aws.domain

  count = var.enable_www ? 1 : 0

  zone_id = data.terraform_remote_state.domain.outputs.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "vanity" {
  provider = aws.domain

  count = var.vanity.enable ? 1 : 0

  zone_id = data.terraform_remote_state.domain.outputs.zone_id
  name    = var.vanity.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}

locals {
  main_subdomain = data.terraform_remote_state.domain.outputs.name
  alt_subdomains = var.enable_www ? ["www.${local.main_subdomain}"] : []
  vanity_subdomains = var.vanity.enable ? ["${var.vanity.name}.${local.main_subdomain}"] : []
  all_subdomains = flatten([[[local.main_subdomain], local.alt_subdomains], local.vanity_subdomains])
}
