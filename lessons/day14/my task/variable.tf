variable "bucket_name" {
  default = "my-terraform-statefile-gokulprasath-unique-12345"
  type = string
  description = "The name of the S3 bucket to store the Terraform state file."
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name."
  type        = string
  default     = "my-static-website-"
}