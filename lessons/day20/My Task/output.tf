# The parent aggregates outputs from the children
output "final_bucket_arn" {
  value = module.storage_module.bucket_arn
}

output "final_server_ip" {
  value = module.compute_module.instance_public_ip
}