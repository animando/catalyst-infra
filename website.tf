resource "aws_s3_bucket" "ui_website_bucket" {
  bucket = "catalyst-ui-bucket"
  acl    = "public-read"
  policy = file("policy.json")
}


resource "aws_s3_bucket_policy" "ui_website_policy" {
  bucket = aws_s3_bucket.ui_website_bucket.id
  policy = data.aws_iam_policy_document.ui_website_policy.json
}

data "aws_iam_policy_document" "ui_website_policy" {
  statement {

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.ui_website_policy.arn,
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
