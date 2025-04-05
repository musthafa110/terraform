provider "aws" {
  region = "ap-south-1"  # Specify your AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "mybucketmsk-b1"  # The name of your S3 bucket
  acl    = "private"  # Access control list for the bucket
}

