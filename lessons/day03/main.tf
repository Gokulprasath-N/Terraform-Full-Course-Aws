terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "my_bucket-bucket" {
  bucket = "my-terraform-statefile-gokulprasath-unique-12345"

  tags = {
    Name        = "My bucket"
    Environment = "backend-test"
  }
}