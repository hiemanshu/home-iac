terraform {
  required_version = ">1"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.81.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}

provider "onepassword" {
  account = var.op_user_id
}

data "onepassword_item" "pve_api_token" {
  vault = var.op_vault_id
  title = "gandalf-api-token"
}

provider "proxmox" {
  endpoint  = var.gandalf_url
  insecure  = true
  api_token = data.onepassword_item.pve_api_token.password
  ssh {
    agent       = false
    username    = "root"
    private_key = file("~/.ssh/id_ed25519")
  }
}
