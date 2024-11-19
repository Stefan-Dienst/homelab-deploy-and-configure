resource "local_file" "ansible_inventory" {
  filename = "../configure/inventory.ini"
  content = <<-EOF
  [nightcrawler]
  ${split("/", proxmox_virtual_environment_container.nightcrawler.initialization[0].ip_config[0].ipv4[0].address)[0]} ansible_ssh_private_key_file="~/.ssh/${proxmox_virtual_environment_container.nightcrawler.initialization[0].hostname}.pem" ansible_user=root
  [forge]
  ${split("/", proxmox_virtual_environment_vm.forge.initialization[0].ip_config[0].ipv4[0].address)[0]} ansible_ssh_private_key_file="~/.ssh/${proxmox_virtual_environment_vm.forge.name}.pem" ansible_user=${proxmox_virtual_environment_vm.forge.name}
  EOF
}
