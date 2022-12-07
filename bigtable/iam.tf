resource "google_bigtable_instance_iam_binding" "editor" {
  instance = "tf-bigtable-instance"
  role     = "roles/bigtable.user"
  members = [
    "user:pruthvi99003871@gmail.com",
  ]
}

resource "google_bigtable_table_iam_binding" "editor" {
  table       = "tf-table1"
  instance    = "tf-bigtable-instance"
  role     = "roles/bigtable.user"
  members = [
    "user:pruthvis2340@gmail.com",
  ]
}
