data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  count       = 2
  name        = "${var.vm_web_name}-${count.index +1}"
  platform_id = var.vm_web_plid
  service_account_id = var.sai

  resources {
   cores         = var.vms_resources_web["cores"]
   memory        = var.vms_resources_web["memory"]
   core_fraction = var.vms_resources_web["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id, ]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}