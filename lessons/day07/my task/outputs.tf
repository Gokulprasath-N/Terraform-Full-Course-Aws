# --- Primitive Outputs ---

output "1_primitive_string" {
  value = "Instance type is: ${var.instance_type}"
}

output "2_primitive_bool_logic" {
  # Demonstrating conditional logic using the bool
  value = var.enable_monitoring ? "Monitoring is ON" : "Monitoring is OFF"
}

# --- Collection Outputs ---

output "3_list_access" {
  # accessing index 0
  value = "First AZ is: ${var.az_names[0]}"
}

output "4_set_deduplication" {
  # Observe how the output will only show [101, 102]
  value = var.user_ids
}

output "5_map_lookup" {
  # Accessing by Key
  value = "The Environment is: ${var.project_tags["Environment"]}"
}

output "6_object_access" {
  # Accessing object attributes using dot notation
  value = "Server Name: ${var.server_config.name}, Active Status: ${var.server_config.is_active}"
}

output "7_tuple_access" {
  # Accessing tuple by index
  value = "Tuple Index 1 (Number) is: ${var.example_tuple[1]}"
}