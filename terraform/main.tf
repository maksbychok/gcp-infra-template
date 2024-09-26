module "api_enablement" {
  source     = "./modules/api_enablement"
  project_id = var.GCP_PROJECT_ID
  apis = [
    "cloudresourcemanager.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
    "servicenetworking.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}

module "network" {
  source        = "./modules/network"
  network_name  = "${var.PROJECT_NAME}-private-network"
  subnet_name   = "${var.PROJECT_NAME}-private-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.GCP_REGION

  depends_on = [module.api_enablement]
}

module "vpc_connector" {
  source         = "./modules/vpc_connector"
  connector_name = "${var.PROJECT_NAME}-vpc-connector"
  region         = var.GCP_REGION
  network        = module.network.network_name
  ip_cidr_range  = "10.8.0.0/28"

  depends_on = [module.api_enablement, module.network]
}

module "secrets" {
  source     = "./modules/secret_manager"
  project_id = var.GCP_PROJECT_ID
  region     = var.GCP_REGION

  secrets = [
    { name = "MY_SECRET_1", value = "supersecretvalue1" },
    { name = "MY_SECRET_2", value = "supersecretvalue2" },
    { name = "MY_SECRET_3", value = "supersecretvalue3" },
    { name = "LAST_TEST", value = "last test var" }
  ]
  service_account_email = var.SA_EMAIL
  depends_on            = [module.api_enablement]
}
module "instance" {
  source        = "./modules/cloud_run"
  service_name  = "${var.PROJECT_NAME}-server"
  region        = var.GCP_REGION
  image         = var.DOCKER_IMAGE
  vpc_connector = module.vpc_connector.self_link
  secrets       = module.secrets.secrets
  depends_on    = [module.secrets, module.api_enablement, module.vpc_connector]
}

module "sql_database" {
  source                  = "./modules/sql_database"
  instance_name           = "${var.PROJECT_NAME}-postgres-instance"
  database_version        = "POSTGRES_16"
  region                  = var.GCP_REGION
  database_name           = "${var.PROJECT_NAME}-db"
  tier                    = "db-f1-micro"
  database_admin_name     = var.SQL_USER
  database_admin_password = var.SQL_PASSWORD
  vpc_network             = module.network.network_self_link

  depends_on = [module.api_enablement, module.network, module.vpc_connector]
}