resource "google_firebase_project" "default" {
  project      = var.project_id
  display_name = var.display_name
}

resource "google_firestore_database" "default" {
  project     = var.project_id
  location_id = var.firestore_location
  name        = "(default)"
  type        = "FIRESTORE_NATIVE"
}