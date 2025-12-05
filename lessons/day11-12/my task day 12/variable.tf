variable "instance_type" {
  type    = string
  default = "t2.micro"

  # Rule 1: Length check
  validation {
    condition     = length(var.instance_type) > 2 && length(var.instance_type) < 20
    error_message = "Instance type must be between 2 and 20 characters."
  }

  # Rule 2: Regex check (Must start with 't2' or 't3')
  validation {
    # 'can' safely checks if the regex matches
    condition     = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "Instance type must start with t2 or t3 (e.g., t2.micro)."
  }
}

variable "db_password" {
  type      = string
  sensitive = true # Hides output in CLI
  default   = "supersecret123"
}

variable "backup_filename" {
  type = string
  validation {
    condition     = endswith(var.backup_filename, "-backup")
    error_message = "Filename must end with '-backup'."
  }
}