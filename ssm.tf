resource "aws_ssm_parameter" "ui_distribution_domain" {
  name  = "UI Cloudfront Distribution Domain Name"
  type  = "String"
  value = aws_cloudfront_distribution.ui_cloudfront_distribution.domain_name
}
