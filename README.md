# Data Engineer Homelab
In this repository I store code to provision and configure my Data Engineer Homelab on my Proxmox VE Cluster.

To use this repo opentofu and ansible need to be installed.
Then follow those steps to setup the homelab:
 1. Set the following environment variables:
    - `export PROXMOX_VE_USERNAME="<your-username>"`
    - `export PROXMOX_VE_PASSWORD="<your-password>"`
    - `export TF_VAR_proxmox_api_endpoint="<your-endpoint>"`
 2. Run `./deploy_and_configure.sh`

## ToDo's
 - [x] Auto generate inventory.ini for deployed container/vms.
 - [ ] Structure /deploy directory in modules.
 - [ ] fix bug in connection to nightcrawler
