resource "proxmox_virtual_environment_download_file" "latest_ubuntu_24_jammy_lxc_img" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "proxmox"
  url          = "http://download.proxmox.com/images/system/ubuntu-24.04-standard_24.04-1_amd64.tar.zst"
}
