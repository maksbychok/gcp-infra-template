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
    # credentials = "/Users/maksbychok/work/gcp-infra-template/keys/neon-fiber-432820-v5-2dbf4edc574a.json"
    bucket = "neon_fiber_tf_remote_state_bucket"
    prefix = "terraform/state"
  }
}
