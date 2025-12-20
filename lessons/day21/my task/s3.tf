resource "aws_s3_bucket" "my_governance_bucket" {
  bucket_prefix = "piyush-terraform-governance-" # Ensures unique name
  force_destroy = true 

  tags = {
    Name        = "MyGovernanceBucket"
    Environment = "Dev"
  }
}