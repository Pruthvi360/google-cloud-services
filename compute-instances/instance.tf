resource "google_compute_instance" "ansible-controller" {
  name = "ansible-controller"
  project = "var.project_id"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
  metadata_startup_script = "#! bin/bash 
}

resource "google_compute_instance" "ansible-local-host-1" {
  name = "ansible-local-host-1"
  project = "var.project_id"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
  lables = "ansible-host"
}

resource "google_compute_instance" "ansible-local-host-2" {
  name = "ansible-local-host-2"
  project = "var.project_id"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
  lables = "ansible-host"
}
