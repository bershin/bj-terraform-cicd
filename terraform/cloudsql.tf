module "sql-db_private_service_access" {
  source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version     = "4.4.0"
  project_id  = var.gcp_project
  vpc_network = data.google_compute_network.network.name
}