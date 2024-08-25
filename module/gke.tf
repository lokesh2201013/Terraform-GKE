resource "google_container_cluster" "gke" {
  count = var.is_gke_cluster_enabled ? 1 : 0
  name  = var.cluster_name
  location = var.location
  initial_node_count = 1
  min_master_version = var.cluster_version

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.private_subnet[0].self_link
  deletion_protection = false
  
  ip_allocation_policy {
    
  }

  master_auth {
     client_certificate_config {
    issue_client_certificate = false
  }
  }

  /*labels = {
    env = var.env
  }*/
}


resource "google_container_node_pool" "ondemand_node_pool" {
  count = var.is_ondemand_node_pool_enabled ? 1 : 0
  name  = "${var.cluster_name}-ondemand-nodes"
  cluster = google_container_cluster.gke[0].name
  location = var.location

  node_config {
    machine_type = var.ondemand_instance_type
    disk_size_gb = 50
  }

    initial_node_count = var.desired_capacity_on_demand

autoscaling {
  min_node_count = var.min_capacity_on_demand
  max_node_count = var.max_capacity_on_demand
}

  

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
resource "google_container_node_pool" "spot_node_pool" {
  count = var.is_spot_node_pool_enabled ? 1 : 0
  name  = "${var.cluster_name}-spot-nodes"
  cluster = google_container_cluster.gke[0].name
  location = var.location

  node_config {
    machine_type = var.spot_instance_type
    disk_size_gb = 50
  }

  initial_node_count = var.desired_capacity_spot
  autoscaling {
      min_node_count = var.min_capacity_spot
  max_node_count = var.max_capacity_spot

  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
