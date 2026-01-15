output "hosts" {
  description = "Host inventory data for downstream inventory generation"
  value = {
    for k, h in var.hosts : k => {
      name         = h.name
      ipv4         = split("/", h.ipv4_cidr)[0]
      ansible_user = h.ansible_user
      groups       = h.groups
    }
  }
}

output "vm_ids" {
  description = "Map of inventory hostname => Proxmox VM/CT ID"
  value       = { for k, h in var.hosts : k => h.vmid }
}
