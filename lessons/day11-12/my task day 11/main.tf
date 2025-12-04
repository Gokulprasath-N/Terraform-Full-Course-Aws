locals {
  # 1. STRING FUNCTIONS
  # Convert "Project Alpha Resource" -> "project-alpha-resource"
  # Steps: Lowercase it -> Replace spaces with hyphens
  formatted_project_name = replace(lower(var.project_name), " ", "-")

  # 2. COLLECTION FUNCTIONS (MERGE)
  # Combine common tags and environment-specific tags into one map
  final_tags = merge(var.tags_common, var.tags_env)

  # 3. LOOKUP FUNCTION
  # Look for the 'prod' key in the map. If not found, default to 't2.micro'.
  selected_instance_type = lookup(var.instance_sizes, var.environment, "t2.micro")
}

# 4. USING THE TRANSFORMED DATA
resource "aws_s3_bucket" "example" {
  # The bucket name will be "project-alpha-resource" (clean and valid)
  bucket = local.formatted_project_name

  tags = local.final_tags
}

resource "aws_instance" "app" {
  ami           = "ami-12345678" # Example AMI
  instance_type = local.selected_instance_type # Will be "t3.large" for prod

  tags = {
    Name = upper("app-server-${var.environment}") # "APP-SERVER-PROD"
  }
}