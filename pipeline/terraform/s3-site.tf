data "aws_iam_policy_document" "site_s3_policy" {
  statement {
    sid     = "bucket_policy_site_main",
    actions   = ["s3:GetObject"]
    effects   = "Allow"
    resources = ["arn:aws:s3:::${local.domain_name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.website_origin_access_identity.iam_arn}"]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "website_origin_access_identity" {
  comment = "site ${terraform.workspace} Access Identity"
}

resource "aws_s3_bucket" "site" {
  bucket = "${local.domain_name}"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.site_s3_policy.json}"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags {}

  force_destroy = true
}

# don't create the domain yet, DNS migration is pending
resource "aws_route53_record" "domain" {
  name    = "${local.domain_name}"
  zone_id = "${local.hosted_zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  # http_version = "http2"

  "origin" {
    origin_id = "origin-bucket-${aws_s3_bucket.site.id}"

    # domain_name = "${aws_s3_bucket.site.website_endpoint}"
    domain_name = "${local.domain_name}.s3.amazonaws.com"

    # custom_origin_config {
    #   origin_protocol_policy = "http-only"
    #   http_port              = "80"
    #   https_port             = "443"
    #   origin_ssl_protocols   = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    # }
    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.website_origin_access_identity.cloudfront_access_identity_path}"
    }
  }
  default_root_object = "index.html"
  custom_error_response {
    error_code = "404"

    # error_caching_min_ttl = "360"
    response_code      = "200"
    response_page_path = "/index.html"
  }
  "default_cache_behavior" {
    allowed_methods = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    "forwarded_values" {
      query_string = "true"

      cookies {
        forward = "none"
      }
    }

    min_ttl          = "0"
    default_ttl      = "300"                                    //3600
    max_ttl          = "1200"                                   //86400
    target_origin_id = "origin-bucket-${aws_s3_bucket.site.id}"

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }
  cache_behavior {
    allowed_methods = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = "true"

      cookies {
        forward = "none"
      }
    }

    min_ttl          = "0"
    default_ttl      = "0"
    max_ttl          = "0"
    target_origin_id = "origin-bucket-${aws_s3_bucket.site.id}"
    path_pattern     = "/index.html"

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }
  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }
  "viewer_certificate" {
    acm_certificate_arn      = "${local.domain_certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
  aliases = ["${local.domain_name}"]
}
