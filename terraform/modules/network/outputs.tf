output "network_name" {
  value = google_compute_network.private.name
}

output "network_id" {
  value = google_compute_network.private.id
}

output "subnetwork_name" {
  value = google_compute_subnetwork.private_subnet.name
}

output "subnet_self_link" {
  value = google_compute_subnetwork.private_subnet.self_link
}

output "network_self_link" {
  value = google_compute_network.private.self_link
}