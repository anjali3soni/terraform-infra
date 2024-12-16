# Purpose: Create an S3 bucket to store the Terraform state file
resource "aws_s3_bucket" "bucket" {
  bucket = local.env.backend_bucket_name
  tags = {
    Name      = local.env.backend_bucket_name
    Terraform = "true"
    workspace = terraform.workspace
  }
}


# ACL for the bucket
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  depends_on              = [aws_s3_bucket.bucket]
}

# Allowing s3 bucket to be public
resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicRead",
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.bucket]
}