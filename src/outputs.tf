output "instance_name_web" {
    value = yandex_compute_instance.platform.name
  
}

output "external_ip_web" {
    value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
  
}
output "fqdn_web" {
    value = yandex_compute_instance.platform.fqdn
  
}

output "instance_name_db" {
    value = yandex_compute_instance.platform_db.name
  
}

output "external_ip_db" {
    value = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
  
}
output "fqdn_db" {
    value = yandex_compute_instance.platform_db.fqdn
  
}