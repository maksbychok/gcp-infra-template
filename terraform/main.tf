module "api_enablement" {
  source       = "./modules/api_enablement"
  project_id   = var.gcp_project_id
  apis = [
    "cloudresourcemanager.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

module "network" {
  source        = "./modules/network"
  network_name  = "${var.project_name}-private-network"
  subnet_name   = "${var.project_name}-private-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region

  depends_on = [ module.api_enablement ]
}

module "vpc_connector" {
  source         = "./modules/vpc_connector"
  connector_name = "${var.project_name}-vpc-connector"
  region         = var.gcp_region
  network        = module.network.network_name
  ip_cidr_range  = "10.8.0.0/28"

  depends_on = [ module.api_enablement, module.network ]
}

module "instance" {
  source        = "./modules/cloud_run"
  service_name  = "${var.project_name}-server"
  region        = var.gcp_region
  image         = "gcr.io/google-samples/hello-app:1.0"
  vpc_connector = module.vpc_connector.self_link

  depends_on = [ module.api_enablement, module.vpc_connector ]
}

module "sql_database" {
  source                    = "./modules/sql_database"
  instance_name             = "${var.project_name}-postgres-instance"
  database_version          = "POSTGRES_16"
  region                    = var.gcp_region
  database_name             = "${var.project_name}-db"
  tier                      = "db-f1-micro"
  database_admin_name       = var.sql_user
  database_admin_password   = var.sql_passpord 
  vpc_network               = module.network.network_self_link

  depends_on = [ module.api_enablement, module.network, module.vpc_connector ]
}
