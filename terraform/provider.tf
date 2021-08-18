provider "google" {
    project = var.gcp_project
    region = var.region
}

provider "random" {
    version = "~> 2.2"
}