resource "aws_s3_bucket" "test_bucket" {
  bucket = "animando-catalyst-test-bucket"
}

resource "aws_s3_bucket_public_access_block" "test_bucket_public_block" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "test_bucket_configuration" {
  bucket = aws_s3_bucket.test_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "test_bucket_address" {
  value = aws_s3_bucket.test_bucket.bucket_regional_domain_name
}
