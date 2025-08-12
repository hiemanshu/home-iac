resource "proxmox_virtual_environment_file" "standard_cloud_config" {
  content_type = "snippets"
  datastore_id = var.import_storage
  node_name    = var.proxmox_node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: redbot
    timezone: Asia/Kolkata
    ssh_pwauth: false
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.laptop_key.content)}
          - ${trimspace(data.local_file.mac_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "standard-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "redbot_vm" {
  name      = "redbot"
  node_name = var.proxmox_node_name

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.69.201/22"
        gateway = "192.168.68.1"
      }
    }

    datastore_id      = var.vm_storage
    user_data_file_id = proxmox_virtual_environment_file.standard_cloud_config.id
  }

  disk {
    datastore_id = var.vm_storage
    import_from  = proxmox_virtual_environment_download_file.ubuntu_noble_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }
}
