# Create a single Compute Engine instance

resource "google_compute_instance" "ansible-controller" {
  name         = "ansible-controller"
  project      = "var.project_id"
  zone         = "us-central1-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # Install Ansible
  metadata_startup_script = "sudo apt-get update; sudo apt-get install ansible"
  provisioning_model = "SPOT"

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
    scheduling {
      provisioning_model = "SPOT"
    }
  }
}

resource "google_compute_instance" "ansible-local-host-1" {
  name = "ansible-local-host-1"
  project = "var.project_id"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
    scheduling {
      provisioning_model = "SPOT"
    }
  }
}

resource "google_compute_instance" "ansible-local-host-2" {
  name = "ansible-local-host-2"
  project = "var.project_id"
  zone = "us-central1-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

 
  provisioning_model = "SPOT"

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
    scheduling {
      provisioning_model = "SPOT"
    }
  }
}
