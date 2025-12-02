# Example 1: Create Before Destroy (Zero Downtime)
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
resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "Zero-Downtime-Server"
  }

  lifecycle {
    # Create the new instance first, THEN destroy the old one.
    create_before_destroy = true
  }
}

# Example 2: Prevent Destroy (Safety Lock)
resource "aws_s3_bucket" "critical_data" {
  bucket = "my-critical-production-data"

  lifecycle {
    # Terraform will ERROR if you try to destroy this resource.
    prevent_destroy = true
  }
}

# Example 3: Ignore Changes (Drift Management)
resource "aws_autoscaling_group" "app_asg" {
  availability_zones  = ["us-east-1a"]
  desired_capacity    = 2
  max_size            = 5
  min_size            = 1

  lifecycle {
    # If the desired_capacity changes (e.g., by an auto-scaling event),
    # Terraform will NOT try to reset it back to 2.
    ignore_changes = [desired_capacity]
  }
}

# Example 4: Replace Triggered By (Chained Dependencies)
resource "aws_instance" "app_server" {
  ami           = "ami-87654321"
  instance_type = "t2.micro"

  lifecycle {
    # If the Security Group changes, this Instance MUST be replaced.
    replace_triggered_by = [
      aws_security_group.app_sg
    ]
  }
}