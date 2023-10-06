terraform {
  required_providers {
    google = {
      version = "~> 4.0.0"
    }
    aws = {
      version = "~> 4.10.0"
    }
  }
}

provider "google" {

  credentials = file(var.gcp_credentials_file_path)

  # Should be able to parse project from credentials file but cannot.
  # Cannot convert string to map and cannot interpolate within variables.
  project = var.gcp_project_id

  region = var.gcp_region
}

provider "aws" {
  shared_credentials_files = pathexpand(var.aws_credentials_file_path)

  region = var.aws_region
}
