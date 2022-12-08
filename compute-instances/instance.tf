# Create a single Compute Engine instance

resource "google_compute_instance" "ansible-controller" {
  provider     = google-beta
  name         = "ansible-controller"
  project      = var.project_id
  zone         = "us-west4-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]
  
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
  name = "ansible-local-host-1"
  project = var.project_id
  zone = "us-west4-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]
  
  labels = {
    environment = "ansible-local-host"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      
     #metadata_startup_script  = "${file("./start.sh")}"
     #}
      labels = {
        my_label = "local-host"
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

resource "google_compute_instance" "ansible-local-host-2" {
  provider = google-beta
  name = "ansible-local-host-2"
  project = var.project_id
  zone = "us-west4-a"
  machine_type = "e2-micro"
  tags         = ["ssh"]
  
  labels = {
    environment = "ansible-local-host"

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
