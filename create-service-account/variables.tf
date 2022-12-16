variable "rolesList" {
type =list(string)
default = ["roles/storage.admin","roles/pubsub.admin","roles/compute.admin","organizations/772284654262/roles/terraformcustomrole1"]
}

variable "project_id" {
type =string
default = "youtube-demo-371510"
}
