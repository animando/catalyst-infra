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

resource "aws_s3_bucket_policy" "ui_website_policy" {
  bucket = aws_s3_bucket.ui_website_bucket.id
  policy = data.aws_iam_policy_document.ui_website_policy.json
}

data "aws_iam_policy_document" "ui_website_policy" {
  statement {

    sid = "Allow Cloudfront read-only access"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.ui_cloudfront_oai.iam_arn]
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
