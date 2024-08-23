resource "google_compute_global_address" "private_ip_range" {
  provider      = google-beta
  name          = "private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.vpc_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}


resource "google_sql_database_instance" "instance_postgres" {
  name              = var.instance_name
  database_version  = var.database_version
  region            = var.region

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled      = false
      private_network   = var.vpc_network 
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "sql_database_default" {
  name     = var.database_name
  instance = google_sql_database_instance.instance_postgres.name
}

resource "google_sql_user" "users" {
  name     = var.database_admin_name
  instance = google_sql_database_instance.instance_postgres.name
  password = var.database_admin_password
}