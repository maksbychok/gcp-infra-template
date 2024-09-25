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
