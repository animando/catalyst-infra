locals {
  s3_origin_id = "uiOriginId"
}

resource "aws_cloudfront_distribution" "ui_cloudfront_distribution" {
  origin {
    domain_name              = aws_s3_bucket.ui_website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Project = "Catalyst"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_address" {
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
}
