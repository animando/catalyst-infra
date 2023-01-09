resource "aws_s3_bucket" "ui_website_bucket" {
  bucket = "catalyst-ui-bucket"
}

resource "aws_s3_bucket_public_access_block" "ui_website_bucket_public_block" {
  bucket = aws_s3_bucket.ui_website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_website_configuration" "ui_website_configuration" {
  bucket = aws_s3_bucket.ui_website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "s3_website_address" {
  value = aws_s3_bucket.ui_website_bucket.bucket_regional_domain_name
}
