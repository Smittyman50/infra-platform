# infra-platform

Reusable building blocks for homelab infrastructure.

## Contents

- **Terraform modules**
  - `terraform/modules/proxmox_vm_fleet`: create a fleet of Proxmox VMs from a cloud-init template

- **Ansible roles**
  - `ansible/roles/base`: baseline Linux configuration (packages, admin user, SSH keys, timezone, qemu-guest-agent)

## Versioning

Tag releases (e.g., `v0.1.0`). Stack repos should pin module/role references to tagged versions.
