# General Variables
env                    = "dev"
location             = "us-east1"
region                = "us-east1"
vpc_name               = "vpc"
pub_subnet_count        = 3
pub_cidr_block         = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20"]
pub_availability_zone  = ["us-east1-a", "us-east1-b", "us-east1-c"]
pub_sub_name           = "subnet-public"
pri_subnet_count        = 3
pri_cidr_block         = ["10.16.128.0/20", "10.16.144.0/20", "10.16.160.0/20"]
pri_availability_zone  = ["us-east1-a", "us-east1-b", "us-east1-c"]
pri_sub_name           = "subnet-private"
public_rt_name         = "public-route-table"
  private_route_name         = "private-route-table"
//eip_name               = "elasticip_ngw"
ngw_name               = "ngw"
gke_cluster_sg = "gke-sg"

# GKE (Google Kubernetes Engine)
is_gke_cluster_enabled     = false
cluster_version            = "1.29"
cluster_name               = "gke-cluster"
//endpoint_private_access    = true
//endpoint_public_access     = false
is_ondemand_node_pool_enabled = false
master_password = "9910"
is_spot_node_pool_enabled = false
ondemand_instance_type = "e2-medium"
spot_instance_type = "n1-standard-1"
desired_capacity_on_demand = 1
min_capacity_on_demand     = 1
max_capacity_on_demand     = 5
desired_capacity_spot      = 1
min_capacity_spot          = 1
max_capacity_spot          = 10
addons = [
  {
    name    = "kubernetes-dashboard",
    version = "2.6.0"
  },
  {
    name    = "cloud-monitoring"
    version = "1.0.0"
  },
  {
    name    = "cloud-logging"
    version = "1.0.0"
  },
  # Add more addons as needed
]
