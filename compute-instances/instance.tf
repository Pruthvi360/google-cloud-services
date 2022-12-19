# Create a single Compute Engine instance
resource "google_service_account" "ansible-service-account" {
  account_id   = "terraform-user@youtube-demo-372114.iam.gserviceaccount.com"
  display_name = "Service Account"
}

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
      image = "ubuntu-minimal-2210-kinetic-amd64-v20221209"
    }
  }

  # Install Ansible
  #metadata_startup_script = "sudo apt update; sudo apt-get install python3-pip -y; sudo apt install ansible -y; ansible-config init --disabled -t all > ansible.cfg"
  
  metadata_startup_script  = "${file("./start.sh")}"
  
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
      image = "ubuntu-minimal-2210-kinetic-amd64-v20221209"
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
      image = "ubuntu-minimal-2210-kinetic-amd64-v20221209"
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
