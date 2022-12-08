# Create a single Compute Engine instance

resource "google_compute_instance" "ansible-controller" {
  provider     = google-beta
  name         = "ansible-controller"
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  tags         = ["ssh","https-server","http-server"]
  
  labels = {
    environment = "ansible-controller"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # Install Ansible
  metadata_startup_script = "sudo apt-get update; sudo apt-get install ansible"

  network_interface {
    network = "default"
    
    access_config {
      // Ephemeral public IP
    }
  }
  
   scheduling {
     preemptible = true
     automatic_restart = false
     provisioning_model = "SPOT"
   }
}

resource "google_compute_instance" "ansible-local-host-1" {
  provider = google-beta
  name = "${var.name}-1"
  project = var.project_id
  zone = var.zone
  machine_type = var.machine_type
  tags         = ["ssh","https-server","http-server"]
  
  labels = {
    environment = var.labels
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
    
    #metadata_startup_script  = "${file("./start.sh")}"
     #}

  network_interface {
    network = "default"
    
    access_config {
      // Ephemeral public IP
    }
  }
  
  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
  }
}

resource "google_compute_instance" "ansible-local-host-2" {
  provider = google-beta
  name = "${var.name}-2"
  project = var.project_id
  zone = var.zone
  machine_type = var.machine_type
  tags         = ["ssh","https-server","http-server"]
  
  labels = {
    environment = "ansible-local-host"
  }
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
      // Ephemeral public IP
    }
  }
  
  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
  }
}
