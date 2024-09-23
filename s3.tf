resource "aws_s3_bucket" "lt_poc" {
    bucket = "pocterraform555ram"
    tags = {
    Application = "testpoc"
    Product = "www.ltpoc.com"
    }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.lt_poc.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "cf_s3_bucket" {
  bucket                = aws_s3_bucket.lt_poc.id
  acl                   = "private"
}

resource "aws_s3_bucket_policy" "public_policy" {
    bucket = aws_s3_bucket.lt_poc.id
    policy = <<EOF
{
    "Id": "SourceIP",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "SourceIP",
        "Action": "s3:*",
        "Effect": "Deny",
        "Resource": [
          "arn:aws:s3:::pocterraform555",
          "arn:aws:s3:::pocterraform555/*"
        ],
        "Condition": {
          "NotIpAddress": {
            "aws:SourceIp": [
              "0.0.0.0/0"
            ]
          }
        },
        "Principal": "*"
      }
    ]
  }
EOF
}