variable "platform" {
  description = "The service application platform, eu or us"
  default     = "eu-bj"
}

variable "env_type" {
  description = "Environment function -- dev, test, stage, or prod"
  default     = "dev"
}

variable "gcp_project" {
  description = "Google Cloud Project for provisioning the environment"
  default     = "bj-terraform-cicd"
}

variable "region" {
  description = "The GCP region for the provisioned services"
  default     = "us-west2"
}