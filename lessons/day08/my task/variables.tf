variable "bucket_names_list" {
  type    = list(string)
  default = ["bucket-from-list-01", "bucket-from-list-02"]
}
variable "bucket_names_set" {
  type    = set(string)
  default = ["bucket-from-set-A", "bucket-from-set-B"]
}