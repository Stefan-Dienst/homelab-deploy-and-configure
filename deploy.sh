#/bin/sh
tofu apply
tofu output -raw ubuntu_container_private_key > ~/.ssh/ubuntu_container_key.pem
chmod 600 ~/.ssh/ubuntu_container_key.pem
ansible-playbook -i inventory.ini python_time_script.yml
