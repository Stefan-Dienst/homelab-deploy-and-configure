resource "proxmox_virtual_environment_container" "nightcrawler" {
  description = "Managed by Terraform"

  node_name = "proxmox"
  vm_id     = 102

  initialization {
    hostname = "nightcrawler"

    ip_config {
      ipv4 {
        address = "192.168.178.51/24"    # Hardcoded static IP address
        gateway = "192.168.178.1"        # Default gateway
      }
    }

    user_account {
      keys = [
        trimspace(tls_private_key.ubuntu_container_key.public_key_openssh)
      ]
      password = random_password.ubuntu_container_password.result
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_ubuntu_24_jammy_lxc_img.id
    type             = "ubuntu"
  }

  disk {
    datastore_id = "local"
    size         = 4
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
}

resource "random_password" "ubuntu_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "ubuntu_container_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "nightcrawler_container_password" {
  value     = random_password.ubuntu_container_password.result
  sensitive = true
}

output "nightcrawler_private_key" {
  value     = tls_private_key.ubuntu_container_key.private_key_pem
  sensitive = true
}

output "nightcrawler_container_public_key" {
  value = tls_private_key.ubuntu_container_key.public_key_openssh
}
