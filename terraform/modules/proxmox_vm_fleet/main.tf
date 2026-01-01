locals {
  hosts = var.hosts
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = local.hosts

  name      = each.value.name
  node_name = each.value.node
  vm_id     = each.value.vmid

  clone {
    vm_id     = var.vm_template_id
    node_name = var.vm_template_node
    full      = true
  }

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory_mb
  }

  disk {
    datastore_id = each.value.datastore
    interface    = "scsi0"
    size         = each.value.disk_gb
  }

  network_device {
    bridge  = each.value.bridge
    vlan_id = try(each.value.vlan, null)
  }

  initialization {
    user_account {
      username = each.value.ansible_user
      keys     = [var.ssh_public_key]
    }

    ip_config {
      ipv4 {
        address = each.value.ipv4_cidr
        gateway = each.value.ipv4_gw
      }
    }
  }

  timeout_clone   = var.timeout_clone
  timeout_create  = var.timeout_create
  timeout_migrate = var.timeout_migrate
}
