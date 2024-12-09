resource "yandex_compute_disk" "disk_vm" {
  count = 3
  name = "disk-${count.index}"
  size = 1
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage
  depends_on = [yandex_compute_disk.disk_vm]
  platform_id = var.vm_web_plid
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

dynamic "secondary_disk" {
  for_each = toset(yandex_compute_disk.disk_vm[*].id) 
  content {
    disk_id = secondary_disk.value
  }
}

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
