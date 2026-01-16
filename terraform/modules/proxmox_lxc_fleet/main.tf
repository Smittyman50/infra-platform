resource "proxmox_virtual_environment_container" "ct" {
  for_each = var.hosts

  node_name     = each.value.node
  vm_id         = each.value.vmid
  unprivileged  = each.value.unprivileged
  start_on_boot = true
  started       = true

  # Optional: reuse groups as tags (or add an explicit tags field later)
  tags = each.value.groups

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory_mb
  }

  operating_system {
    template_file_id = var.ct_template_file_id
    type             = each.value.os_type
  }

  features {
    nesting = true
  }

  network_interface {
    name    = "eth0"
    bridge  = each.value.bridge
    vlan_id = try(each.value.vlan, null)
  }

  disk {
    datastore_id = each.value.datastore
    size         = each.value.disk_gb
  }

  initialization {
    hostname = each.value.name

    ip_config {
      ipv4 {
        address = each.value.ipv4_cidr
        gateway = each.value.ipv4_gw
      }
    }

    user_account {
      keys = [var.ssh_public_key]
      password = var.ct_console_password
    }
  }
}
