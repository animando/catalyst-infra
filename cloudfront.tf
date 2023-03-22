# locals {
#   s3_origin_id = "uiOriginId"
# }

# resource "aws_cloudfront_origin_access_control" "ui_cloudfront_origin_access_control" {
#   name                              = "UI Cloudfront Access Control Policy"
#   description                       = ""
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

# resource "aws_cloudfront_origin_access_identity" "ui_cloudfront_oai" {
#   comment = "UI Cloudfront Origin Access Identity"
# }

# resource "aws_cloudfront_distribution" "ui_cloudfront_distribution" {
#   origin {
#     domain_name              = aws_s3_bucket.ui_website_bucket.bucket_regional_domain_name
#     origin_id                = local.s3_origin_id
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.ui_cloudfront_oai.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   default_root_object = "index.html"

#   lifecycle {
#     ignore_changes = [
#       default_cache_behavior[0].lambda_function_association, # added by serverless auth lambda
#     ]
#   }

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#       locations        = []
#     }
#   }

#   tags = {
#     Name = "Catalyst UI Distribution"
#     Project = "Catalyst"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
