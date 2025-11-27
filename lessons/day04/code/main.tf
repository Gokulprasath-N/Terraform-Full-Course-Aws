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

# backend configuration
terraform {
  backend "s3" {
    bucket         = "my-terraform-statefile-gokulprasath-unique-12345"
    key            = "backend/backup/terraform.tfstate"
    region         = "us-east-1"

    # It prevents two people (or two CI/CD pipelines) 
    # from running terraform apply at the exact same time.
    use_lockfile  = "true"

    # When Terraform uploads your state file (terraform.tfstate) to the S3 bucket, Amazon S3 encrypts it before saving it to the disk. It decrypts it automatically when Terraform needs to read it.
    encrypt        = true
  }
}
# Simple test resource to verify remote backend
resource "aws_s3_bucket" "test_backend" {
  bucket = "gokulprasath-terraform-backend-12345"

  tags = {
    Name        = "Test Backend Bucket"
    Environment = "dev"
  }
}


