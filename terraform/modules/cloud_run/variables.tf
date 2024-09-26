variable "service_name" {}
variable "region" {}
variable "image" {}
variable "vpc_connector" {}
variable "secrets" {
  description = "List of secret objects with name and value"
  type = list(object({
    name  = string
    value = string # Тепер value буде ID секрету
  }))
}