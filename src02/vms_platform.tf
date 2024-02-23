variable "vm_db_plid" {
  type        = string
  default     = "standard-v1"
  
}

variable vms_resources_db  {
  type            = map
  default= {
    cores           = 2
    memory          = 2
    core_fraction   = 5
  }
 }


data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image
}
resource "yandex_compute_instance" "platform_db" {
  name        = local.vms_db_name
  platform_id = var.vm_db_plid

  zone        = var.default_zone_b

  resources {
    cores         = var.vms_resources_db["cores"]
    memory        = var.vms_resources_db["memory"]
    core_fraction = var.vms_resources_db["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}