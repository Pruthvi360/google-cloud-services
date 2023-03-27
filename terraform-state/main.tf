provider "google" {
  project     = "on-prem-381812"
  region      = "us-central-1"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "terraform-state-1996"
  location    = "US"
  uniform_bucket_level_access = true
}

terraform { 
  backend "local" { 
    path = "terraform/state/terraform.tfstate" 
  } 
}

#terraform {
# backend "gcs"
#  bucket  = "terraform-state-1996"
#    prefix  = "terraform/state"
#}
#}
