resource "proxmox_virtual_environment_vm" "forge" {
  name      = "forge"
  node_name = "proxmox"
  description = "Managed by Terraform"
  vm_id     = "103"


  cpu {
    cores = 1
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = 1024
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  disk {
      datastore_id = "local-lvm"
      file_id      = proxmox_virtual_environment_file.ubuntu_cloud_image.id
      interface    = "scsi0"
    }

  network_device {
    bridge = "vmbr0"
  }

  initialization {

    ip_config {
      ipv4 {
        address = "192.168.178.52/24"    # Hardcoded static IP address
        gateway = "192.168.178.1"        # Default gateway
      }
    }

  user_account {
      keys     = [trimspace(tls_private_key.ubuntu_vm_key.public_key_openssh)]
      password = random_password.ubuntu_vm_password.result
      username = "forge"
    }
  }

}

resource "random_password" "ubuntu_vm_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "ubuntu_vm_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "forge_password" {
  value     = random_password.ubuntu_vm_password.result
  sensitive = true
}

output "forge_private_key" {
  value     = tls_private_key.ubuntu_vm_key.private_key_pem
  sensitive = true
}

output "forge_public_key" {
  value = tls_private_key.ubuntu_vm_key.public_key_openssh
}
