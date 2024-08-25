locals {
  env = var.env
}

module "gke" {
  region = var.region
  location = var.location
  source = "../module"
  env = var.env
  cluster_name          = "${local.env}-${var.cluster_name}"
  vpc_name              = "${local.env}-${var.vpc_name}"
  pub_subnet_count      = var.pub_subnet_count
  pub_cidr_block        = var.pub_cidr_block
  pub_availability_zone = var.pub_availability_zone
  pub_sub_name          = "${local.env}-${var.pub_sub_name}"
  pri_subnet_count      = var.pri_subnet_count
  pri_cidr_block        = var.pri_cidr_block
  pri_availability_zone = var.pri_availability_zone
  pri_sub_name          = "${local.env}-${var.pri_sub_name}"
  public_rt_name        = "${local.env}-${var.public_rt_name}"
  private_route_name       = "${local.env}-${var.private_route_name}"
  //eip_name              = "${local.env}-${var.eip_name}"
  ngw_name              = "${local.env}-${var.ngw_name}"
  gke_cluster_sg                = var.gke_cluster_sg
 ondemand_instance_type = var.ondemand_instance_type
  spot_instance_type    = var.spot_instance_type
  master_password       = var.master_password
  desired_capacity_on_demand    = var.desired_capacity_on_demand
  min_capacity_on_demand        = var.min_capacity_on_demand
  max_capacity_on_demand        = var.max_capacity_on_demand
  desired_capacity_spot         = var.desired_capacity_spot
  min_capacity_spot             = var.min_capacity_spot
  max_capacity_spot             = var.max_capacity_spot
  is_gke_cluster_enabled        = var.is_gke_cluster_enabled
  cluster_version               = var.cluster_version
  //endpoint_private_access       = var.endpoint_private_access
  //endpoint_public_access        = var.endpoint_public_access
  is_ondemand_node_pool_enabled = var.is_ondemand_node_pool_enabled
  is_spot_node_pool_enabled     = var.is_spot_node_pool_enabled
  addons = var.addons
}
