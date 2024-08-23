variable instance_name {}
variable database_version {}
variable region {}
variable tier {}
variable database_name {}
variable database_admin_name {}
variable database_admin_password {}
variable vpc_network {
  description = "VPC network to use for the private IP address"
  type        = string
}
