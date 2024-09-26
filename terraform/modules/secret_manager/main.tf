
resource "google_secret_manager_secret" "this" {
  count     = length(var.secrets)
  secret_id = var.secrets[count.index].name
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "this" {
  count       = length(var.secrets)
  secret      = google_secret_manager_secret.this[count.index].id
  secret_data = var.secrets[count.index].value
}

resource "google_secret_manager_secret_iam_member" "accessor" {
  count     = length(google_secret_manager_secret.this)
  secret_id = google_secret_manager_secret.this[count.index].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}