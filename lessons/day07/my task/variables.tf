# --- Primitive Types ---

# 1. String
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

# 2. Number
variable "instance_count" {
  description = "Number of instances to provision"
  type        = number
  default     = 1
}

# 3. Bool
variable "enable_monitoring" {
  description = "Enable detailed monitoring?"
  type        = bool
  default     = true
}

# --- Complex Types (Collections) ---

# 4. List (Ordered, allows duplicates)
variable "az_names" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1a"] 
  # Note: I added a duplicate 'us-east-1a' here to prove Lists keep duplicates
}

# 5. Set (Unordered, removes duplicates)
variable "user_ids" {
  description = "Set of User IDs"
  type        = set(number)
  default     = [101, 102, 101] 
  # Note: Terraform will automatically remove the second '101'
}

# 6. Map (Key-Value pairs of same type)
variable "project_tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "Alpha"
    Owner       = "Team-Ops"
  }
}

# 7. Object (Grouping different types)
variable "server_config" {
  description = "Configuration object for the web server"
  type = object({
    name      = string
    instances = number
    is_active = bool
  })
  default = {
    name      = "web-server"
    instances = 2
    is_active = true
  }
}

# 8. Tuple (Fixed sequence of different types)
variable "example_tuple" {
  description = "A specific tuple sequence"
  type        = tuple([string, number, bool])
  default     = ["server01", 4, true]
}

# --- Special Types ---

# 9. Any (Dynamic typing - use sparingly)
variable "arbitrary_data" {
  description = "Variable that accepts anything"
  type        = any
  default     = "I can be a string, number, or object"
}