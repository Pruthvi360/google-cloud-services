data "google_compute_instance" "ansible-controller" {
  name = "ansible-controller"
  project = "ansible-demo-371016"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
}

data "google_compute_instance" "ansible-local-host-1" {
  name = "ansible-local-host-1"
  project = "ansible-demo-371016"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
  lables = "ansible-host"
}

data "google_compute_instance" "ansible-local-host-2" {
  name = "ansible-local-host-2"
  project = "ansible-demo-371016"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  provisioning_model = "SPOT"
  lables = "ansible-host"
}
