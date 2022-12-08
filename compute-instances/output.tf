output "ansible-controller-ip" {
  value = google_compute_instance.ansible-controller.network_interface.0.access_config.0.nat_ip
}

output "ansible-local-host-1-ip" {
  value = google_compute_instance.ansible-local-host-1.network_interface.0.access_config.0.nat_ip
}

output "ansible-local-host-2-ip" {
  value = google_compute_instance.ansible-local-host-2.network_interface.0.access_config.0.nat_ip
}
