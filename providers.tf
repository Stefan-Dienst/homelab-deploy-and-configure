terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.66.3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_endpoint
  insecure  = true
  # ssh {
  #   agent    = true
  # }
}
