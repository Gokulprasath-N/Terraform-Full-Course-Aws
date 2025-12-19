provider "aws" {
  region = var.aws_region
}

# Call the Storage Child Module
module "storage_module" {
  source      = "./modules/storage"
  bucket_name = var.root_bucket_name
}

# Call the Compute Child Module
module "compute_module" {
  source        = "./modules/compute"
  instance_type = "t2.micro"
}