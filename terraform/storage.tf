data "google_compute_network" "network" {
  name = format("cicd-%s", var.gcp_project)
}