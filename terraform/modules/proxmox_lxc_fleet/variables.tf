variable "ct_template_file_id" {
  type        = string
  description = "Proxmox CT template file ID (e.g. local:vztmpl/debian-12-standard_*.tar.zst)"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected via container initialization"
}

variable "ct_console_password" {
  type        = string
  description = "Console password for the container's initialized user account (optional)"
  sensitive   = true
  default     = null
}

variable "hosts" {
  description = "Host specs keyed by inventory hostname."
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
    ipv4_cidr    = string
    ipv4_gw      = string
    ansible_user = string
    groups       = list(string)

    # LXC-specific optional
    unprivileged = optional(bool, true)
    os_type      = optional(string, "debian")
  }))
}

variable "timeout_create" {
  type        = number
  description = "Create timeout seconds"
  default     = 1800
}
