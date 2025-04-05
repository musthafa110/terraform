provider "aws" {
  region = "ap-south-1"  # Change to your desired AWS region
}

# Create the S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-msk-bucket-12345"  # Ensure the bucket name is globally unique
}

# Upload the object with a private ACL (object is kept private)
resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "prom.png"  # The object name and path in the bucket
  source = "/home/musthafa/terraform/prom.png"  # Path to the local file to upload
  acl    = "private"  # Keep the object private
}

# Set the bucket policy to allow public read access to all objects in the bucket
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.bucket

  policy = data.aws_iam_policy_document.s3_public_read_policy.json
}

# Define the public read policy in the IAM policy document
data "aws_iam_policy_document" "s3_public_read_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.my_bucket.arn}/*"]
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

