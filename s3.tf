resource "aws_s3_bucket" "test_bucket" {
  bucket = "animando-catalyst-test-bucket"
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
