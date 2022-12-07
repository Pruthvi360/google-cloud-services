# Project definition
resource "google_project" "data-lake" {
  name       = "Data Lake"
  project_id = "cloud-iac-data-lake" # Replace with an unique project ID
  billing_account = local.billing_id # Replace with your billing ID
}

resource "google_project" "data-warehouse" {
  name       = "Data Warehouse"
  project_id = "cloud-iac-data-warehouse" # Replace with an unique project ID
  billing_account = local.billing_id # Replace with your billing ID
}

resource "google_project" "data-marts" {
  name       = "Data Marts"
  project_id = "cloud-iac-data-marts" # Replace with an unique project ID
  billing_account = local.billing_id # Replace with your billing ID
}
