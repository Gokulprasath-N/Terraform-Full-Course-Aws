variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "root_bucket_name" {
  description = "Unique name for the S3 bucket passed from root"
  type        = string
  # Replace this default with a unique name or pass it via terraform.tfvars
  default     = "my-terraform-test-bucket-12345-unique" 
}