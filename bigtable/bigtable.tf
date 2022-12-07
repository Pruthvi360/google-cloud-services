resource "google_bigtable_instance" "production-instance" {
  name = "tf-bigtable-instance"
  project = "bigtable-demo-370915"

  # A cluster with fixed number of nodes.
  cluster {
    cluster_id   = "tf-instance-cluster1"
    num_nodes    = 1
    storage_type = "HDD"
    zone    = "us-central1-c"
  }

  # a cluster with auto scaling.
  cluster {
    cluster_id   = "tf-instance-cluster2"
    storage_type = "HDD"
    zone    = "us-central1-b"
    autoscaling_config {
      min_nodes = 1
      max_nodes = 3
      cpu_target = 50
    }
  }

  labels = {
    my-label = "prod-label"
  }
}

resource "google_bigtable_table" "table" {
  name          = "tf-table"
  instance_name = google_bigtable_instance.production-instance.name
  split_keys    = ["a", "b", "c"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_bigtable_table" "table1" {
  name          = "tf-table1"
  instance_name = google_bigtable_instance.production-instance.name
  split_keys    = ["a", "b", "c"]

  lifecycle {
    prevent_destroy = true
  }
}
