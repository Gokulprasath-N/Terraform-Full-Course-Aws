variable "project_name" {
  type    = string
  default = "Project Alpha Resource"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "instance_sizes" {
  type = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t3.small"
    prod    = "t3.large"
  }
}

variable "tags_common" {
  type = map(string)
  default = {
    Owner = "DevOps Team"
  }
}

variable "tags_env" {
  type = map(string)
  default = {
    Environment = "Production"
  }
}