variable "gcp_project" {
  description = "Google Cloud Project for provisioning the environment"
  default     = "bj-terraform-cicd"
}

variable "region" {
  description = "The GCP region for the provisioned services"
  default     = "us-west2"
}
