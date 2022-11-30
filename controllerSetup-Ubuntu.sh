# Different releases of Ubuntu have different defualt Python versions
PS3="Select Ubuntu version: "

select ubuntu_controller_ver in 20.04 22.04 Quit
do
    case $ubuntu_controller_ver in
        "20.04")
            controller_python_ver="python3.8"
            break;;
        "22.04")
            controller_python_ver="python3"
            break;;
        "Quit")
            echo "Quit"
            break;;
        *)
           echo "Enter a valid number";;
    esac
done

# Installs Git, Ansible, Docker/Docker-Compose Python modules, and Terraform on Ubuntu 20.04 host

printf "\ninstalling Git and curl...\n"
sudo apt install -y git curl

printf "\ninstalling pip and Ansible...\n"
echo "export PATH=\"$HOME/.local/bin:$PATH\"" >> $HOME/.bashrc
source $HOME/.bashrc
sudo apt install -y python3-distutils python3-testresources sshpass
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
$controller_python_ver get-pip.py --user && $controller_python_ver -m pip install --user ansible


#printf "\ninstalling Docker and Docker-Compose Python modules...\n"
#pip install docker docker-compose

printf "\ninstalling Terraform...\n"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

printf "\nenabling Terraform tab completion...\n"
touch ~/.bashrc
terraform -install-autocomplete

printf "\ninstalling Packer...\n"
sudo apt-get install packer

printf "\nDone.\n"
terraform --version && echo && git --version && echo && ansible --version
