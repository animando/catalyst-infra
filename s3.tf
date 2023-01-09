resource "aws_s3_bucket" "test_bucket" {
  bucket = "animando-catalyst-test-bucket"
}

resource "aws_s3_bucket_policy" "test_bucket_policy" {
  bucket = aws_s3_bucket.test_bucket.id
  policy = data.aws_iam_policy_document.test_bucket_policy.json
}

data "aws_iam_policy_document" "test_bucket_policy" {
  statement {

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.test_bucket.arn,
      "${aws_s3_bucket.test_bucket.arn}/*",
    ]
  }
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
