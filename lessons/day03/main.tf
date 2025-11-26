terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.1"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "us-east-1"
}

# Create a S3 bucket
resource "aws_s3_bucket" "S3_bucket_test" {
  bucket = "my-s3-bucket-unique-name-gokulprasath-12345"

  tags = {
    Name        = "My bucket"
    Environment = "testing"
  }
}