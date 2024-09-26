output "secrets" {
  value = [for i in google_secret_manager_secret.this : {
    name  = i.secret_id
    value = i.id # Додаємо ID секрету
  }]
}