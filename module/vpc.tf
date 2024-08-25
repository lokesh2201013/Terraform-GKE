locals {
  cluster_name = var.cluster_name
  env          = var.env
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  description             = "VPC for ${local.cluster_name} in GCP"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "public_subnet" {
  count        = var.pub_subnet_count
  name         = "${var.pub_sub_name}-${count.index + 1}"
  network      = google_compute_network.vpc.self_link
  ip_cidr_range = element(var.pub_cidr_block, count.index)
  region       = var.region
  /*labels = {
    Env = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }*/
}

resource "google_compute_subnetwork" "private_subnet" {
  count        = var.pri_subnet_count
  name         = "${var.pri_sub_name}-${count.index + 1}"
  network      =  google_compute_network.vpc.self_link
  ip_cidr_range = element(var.pri_cidr_block, count.index)
  region       = var.region
   
  /*labels = {
    Env = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb" = "1"
  }*/
}

resource "google_compute_router" "vpc_router" {
  name    = "${local.cluster_name}-router"
  network = google_compute_network.vpc.self_link
  region  = var.region
}

resource "google_compute_router_nat" "vpc_nat" {
  name                               = var.ngw_name
  router                             = google_compute_router.vpc_router.name
  region                             = google_compute_router.vpc_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_route" "default_internet_route" {
  name              = var.public_rt_name
  network           = google_compute_network.vpc.self_link
  dest_range        = "0.0.0.0/0"
  next_hop_gateway  = "default-internet-gateway"
  priority          = 1000
}

resource "google_compute_route" "private_route" {
  name        = "${local.env}-${var.private_route_name}"
  network     = google_compute_network.vpc.self_link
  dest_range = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway" # or use a specific instance
  priority    = 1000
}


resource "google_compute_firewall" "gke_cluster_sg" {
  name    = var.gke_cluster_sg
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}
