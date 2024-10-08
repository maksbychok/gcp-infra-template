resource "google_cloud_run_v2_service" "this" {
  name     = var.service_name
  location = var.region
  template {
    containers {
      dynamic "env" {
        for_each = var.secrets
        content {
          name = env.value.name
          value_source {
            secret_key_ref {
              secret  = env.value.value
              version = "latest"
            }
          }
        }
      }
      image = var.image
      ports {
        container_port = 3000
      }
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_v2_service.this.name
  location = google_cloud_run_v2_service.this.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}