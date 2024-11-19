#/bin/sh
cd deploy
tofu apply -auto-approve
tofu output -raw ubuntu_container_private_key > ~/.ssh/ubuntu_container_key.pem
tofu output -raw ubuntu_vm_private_key > ~/.ssh/ubuntu_vm_key.pem
chmod 600 $HOME/.ssh/ubuntu_container_key.pem
chmod 600 $HOME/.ssh/ubuntu_vm_key.pem
cd ..
cd configure
sleep 30
ansible-playbook -i inventory.ini python_time_script.yml
ansible-playbook -i inventory.ini install_github_runner.yml
