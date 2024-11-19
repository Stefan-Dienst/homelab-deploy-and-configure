#/bin/sh
cd deploy
tofu apply -auto-approve
tofu output -raw nightcrawler_private_key > ~/.ssh/nightcrawler.pem
tofu output -raw forge_private_key > ~/.ssh/forge.pem
chmod 600 $HOME/.ssh/nightcrawler.pem
chmod 600 $HOME/.ssh/forge.pem
cd ..
cd configure
sleep 30
ansible-playbook -i inventory.ini python_time_script.yml
ansible-playbook -i inventory.ini install_github_runner.yml
