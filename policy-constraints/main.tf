terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.84"
    }
  }
}
resource "google_project_iam_binding" "sample_iam_binding" {
  project = "phrasal-door-373004"
  role    = "roles/viewer"
  members = [
    "user:"pruthvi16091996@gmail.com"
  ]
}


