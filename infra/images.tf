resource "proxmox_virtual_environment_download_file" "ubuntu_noble_image" {
  content_type = "import"
  datastore_id = var.import_storage
  node_name    = var.proxmox_node_name
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}
