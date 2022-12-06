resource "google_service_account" "terraform_user" {
account_id   = "terraform-user"
display_name = "terraform User"
}

resource "google_project_iam_binding" "terraform_user" {
project = var.project_id
count = length(var.rolesList)
role =  var.rolesList[count.index]
members = [
  "serviceAccount:${google_service_account.terraform_user.email}"
]
}
