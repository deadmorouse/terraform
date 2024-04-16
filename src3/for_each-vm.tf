  variable "each_vm" {
  type =  list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 5
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 4
      disk_volume = 5
    }
  ]
}

resource "yandex_compute_instance" "platformDB" {
  depends_on = [ yandex_compute_instance.platform ]

  for_each =  { for vm in var.each_vm: "${vm.vm_name}" => vm }

  name   = each.value["vm_name"]
  
  resources {
  
  cores  = each.value["cpu"]
  memory = each.value["ram"]
  core_fraction = each.value["disk_volume"]
  }

  network_interface {
     subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  
 
  }
   scheduling_policy {
      preemptible = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
