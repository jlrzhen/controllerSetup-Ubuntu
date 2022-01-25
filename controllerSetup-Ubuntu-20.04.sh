# Installs Git, Ansible, and Terraform on Ubuntu 20.04 host

printf "\ninstalling Git...\n"
sudo apt install -y git

printf "\ninstalling Ansible...\n"
sudo apt install -y python3-distutils python3-testresources
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user && python3 -m pip install --user ansible
echo "export PATH=\"$HOME/.local/bin:$PATH\"" >> .bashrc

printf "\ninstalling Terraform...\n"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

printf "\nenabling Terraform tab completion...\n"
touch ~/.bashrc
terraform -install-autocomplete

printf "\nDone.\n"
terraform --version && echo && git --version && echo && ~/.local/bin/ansible --version
