#GCP provider

provider "google" {
  credentials = var.GCP_KEY
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
}

provider "google-beta" {
  credentials = var.GCP_KEY
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
}

terraform {
  backend "gcs" {
    bucket = "neon_fiber_tf_remote_state_bucket"
    prefix = "terraform/state"
  }
}
