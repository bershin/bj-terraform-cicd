module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.4"

  project_id                             = var.gcp_project
  network_name                           = format("cicd-%s", var.gcp_project)
  routing_mode                           = "GLOBAL"
  delete_default_internet_gateway_routes = false

  subnets = [
    {
      subnet_name           = "us-west01"
      subnet_ip             = "10.138.0.0/20"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "us-east01"
      subnet_ip             = "10.142.0.0/20"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "europe-west02"
      subnet_ip             = "10.154.0.0/20"
      subnet_region         = "europe-west2"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  secondary_ranges = {
    us-west01 = [
      {
        range_name    = "us-west1-01-gke-01-pods"
        ip_cidr_range = "10.8.0.0/14"
      },
      {
        range_name    = "us-west1-01-gke-01-services"
        ip_cidr_range = "10.75.0.0/20"
      },
    ]

    us-east01 = [
      {
        range_name    = "us-east1-01-gke-01-pods"
        ip_cidr_range = "10.12.0.0/14"
      },
      {
        range_name    = "us-east1-01-gke-01-services"
        ip_cidr_range = "10.75.16.0/20"
      },
    ],
    europe-west02 = [
      {
        range_name    = "europe-west02-01-gke-01-pods"
        ip_cidr_range = "10.16.0.0/14"
      },
      {
        range_name    = "europe-west1-02-gke-01-services"
        ip_cidr_range = "10.75.32.0/20"
      },
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through NAT to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]
}
