locals {
  # --- NUMERIC FUNCTIONS ---
  costs = [100, 250, 50, -20] # Negative implies credit

  # Calculate absolute values (convert -20 to 20)
  abs_costs = [for c in local.costs : abs(c)]

  # Find Max/Min/Sum
  # NOTE: We MUST use the spread operator (...) because 'max' expects separate args
  max_cost   = max(local.abs_costs...) 
  total_cost = sum(local.abs_costs)

  # --- FILE FUNCTIONS ---
  # Check if config exists, then read and parse it
  config_file_path = "${path.module}/config.json"
  
  app_config = fileexists(local.config_file_path) ? jsondecode(file(local.config_file_path)) : {"file_status" = "Config not found"}
  
  # --- DATE FUNCTIONS ---
  # Format current time: "2023-Oct-05"
  formatted_date = formatdate("YYYY-MMM-DD", timestamp())
}

# Output the calculated results
output "cost_analysis" {
  value = {
    highest_expense = local.max_cost
    total_spend     = local.total_cost
  }
}

output "database_config" {
  # If config.json existed, we output the parsed 'database' key
  value = try(local.app_config.database, "No config found")
}