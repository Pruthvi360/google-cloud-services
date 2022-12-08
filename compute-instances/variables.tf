variable "project_id" {
type =string
default = "ansible-demo-371016"
}

variable "region" {
  description = "GCP region name."
  type        = string
  default     = "us-west4"
}

variable "zone" {
  description = "GCP zone name."
  type        = string
  default     = "us-west4-b"
}

variable "name" {
  description = "Web server name."
  type        = string
  default     = "my-webserver"
}

variable "machine_type" {
  description = "GCP VM instance machine type."
  type        = string
  default     = "e2-micro"
}

variable "labels" {
  description = "List of labels to attach to the VM instance."
  type        = ansible
}
