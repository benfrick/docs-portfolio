resource "aws_s3_bucket" "site" {
    bucket = "${local.domain_name}"
    acl = "public-read"
    policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${local.domain_name}/*",
      "Principal": "*"
    }
  ]
}
EOF
    website {
        index_document = "index.html"
        error_document = "404.html"
    }
    tags {
    }
    force_destroy = true
}

resource "aws_route53_record" "domain" {
   name = "${local.domain_name}"
   zone_id = "${local.hosted_zone_id}"
   type = "A"
   alias {
      name = "s3-website-${var.region}.amazonaws.com."
      zone_id = "${aws_s3_bucket.site.hosted_zone_id}"
    #  name = "${var.route53_domain_alias_name}"
    #  zone_id = "${var.hosted_zone_id}"
    #  name = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    #  zone_id = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
      evaluate_target_health = true
   }
}
