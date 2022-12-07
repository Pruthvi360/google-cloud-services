resource "google_bigtable_instance_iam_binding" "editor" {
  instance = "myfirst-bigtable-instance"
  role     = "roles/bigtable.user"
  members = [
    "user:pruthvi.co.in",
  ]
}
