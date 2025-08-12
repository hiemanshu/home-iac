variable "proxmox_node_name" {
  type        = string
  description = "Default proxmox node name"
}

variable "op_vault_id" {
  type        = string
  description = "1Password Vault ID with secrets"
}

variable "op_user_id" {
  type        = string
  description = "1Password User ID from CLI"
}

variable "gandalf_url" {
  type        = string
  description = "Gandalf PVE URL"
}

variable "import_storage" {
  type        = string
  description = "Storage for imported images and snippets"
  default     = "local"
}

variable "vm_storage" {
  type        = string
  description = "Storage for VM's disk files"
  default     = "local-zfs"
}
