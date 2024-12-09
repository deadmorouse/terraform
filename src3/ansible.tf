resource "local_file" "ansible_inventory" {
  filename = "./inventory.yml"
  content = templatefile("ansible_temp.tftpl", {
    webservers = yandex_compute_instance.platform,
    databases = yandex_compute_instance.platformDB,
    storage = [yandex_compute_instance.storage],
  })
}
