# 2. Resources (main.tf)
# Example 1: Using COUNT (Iterating over a List)
resource "aws_s3_bucket" "count_example" {
  # count expects a whole number. We calculate the length of the list.
  count = length(var.bucket_names_list) 
  # We access the specific item using the index (0, 1, 2)
  bucket = var.bucket_names_list[count.index]
  tags = {
    Name = "Count-Bucket-${count.index}"
  }
}

# Example 2: Using FOR_EACH (Iterating over a Set)
resource "aws_s3_bucket" "foreach_example" {
  # for_each expects a Set or Map.
  for_each = var.bucket_names_set
  # We access the item using 'each.key' or 'each.value'
  # In a Set, key and value are the same.
  bucket = each.value
  tags = {
    Name = "ForEach-Bucket-${each.key}"
  }
  # Example 3: Using DEPENDS_ON (Explicit Dependency)
  # This tells Terraform: "Do not start creating these buckets 
  # until the 'count_example' buckets are fully finished."
  depends_on = [
    aws_s3_bucket.count_example
  ]
}