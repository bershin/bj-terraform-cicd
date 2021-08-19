terraform {
  backend "gcs" {
    bucket = "terraform-state-bj"
  }
}
