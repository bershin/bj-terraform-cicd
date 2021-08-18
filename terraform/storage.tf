module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 1.7.2"

  name          = local.server_prefix
  project_id    = var.gcp_project
  location      = var.region
  storage_class = "STANDARD"
  versioning    = true
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "allUsers"
    }
  ]
  force_destroy = true
}