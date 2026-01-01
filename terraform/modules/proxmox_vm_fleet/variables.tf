variable "vm_template_id" {
  type        = number
  description = "Proxmox VM ID of the cloud-init template to clone"
}

variable "vm_template_node" {
  type        = string
  description = "Proxmox node where the source template VM resides"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected via cloud-init"
}

# Fleet specification
variable "hosts" {
  description = "Host specs keyed by inventory hostname (e.g., dc1, dc2)."
  type = map(object({
    node         = string
    vmid         = number
    name         = string
    cpu_cores    = number
    memory_mb    = number
    disk_gb      = number
    datastore    = string
    bridge       = string
    vlan         = optional(number)
    ipv4_cidr    = string   # e.g. 192.168.10.50/24
    ipv4_gw      = string   # e.g. 192.168.10.1
    ansible_user = string   # e.g. ubuntu
    groups       = list(string)
  }))
}

# Optional tunables
variable "timeout_clone" {
  type        = number
  description = "Clone timeout seconds"
  default     = 1800
}

variable "timeout_create" {
  type        = number
  description = "Create timeout seconds"
  default     = 1800
}

variable "timeout_migrate" {
  type        = number
  description = "Migrate timeout seconds"
  default     = 1800
}
