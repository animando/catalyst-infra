resource "aws_s3_bucket" "ui_website_bucket" {
  bucket = "catalyst-ui-bucket"
}

resource "aws_s3_bucket_acl" "ui_website_bucket_acl" {
  bucket = aws_s3_bucket.ui_website_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "ui_website_policy" {
  bucket = aws_s3_bucket.ui_website_bucket.id
  policy = data.aws_iam_policy_document.ui_website_policy.json
}

data "aws_iam_policy_document" "ui_website_policy" {
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
      aws_s3_bucket.ui_website_bucket.arn,
      "${aws_s3_bucket.ui_website_bucket.arn}/*",
    ]
  }
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
