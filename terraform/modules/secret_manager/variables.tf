variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "secrets" {
  description = "List of secret objects with name and value"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "service_account_email" {
  description = "Email of the service account that needs access to the secrets"
  type        = string
}