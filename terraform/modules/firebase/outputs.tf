output "firebase_project_id" {
  value = google_firebase_project.default.project
}

output "firestore_database_id" {
  value = google_firestore_database.default.database_id
}
