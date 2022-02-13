# Installs Jenkins on Ubuntu 20.04
sudo apt update
sudo apt install openjdk-11-jdk
java -version

# https://stackoverflow.com/questions/69495517/unable-to-install-jenkins-on-ubuntu-20-04?rq=1
sudo apt install ca-certificates -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

sudo usermod -a -G root jenkins
sudo systemctl restart jenkins
sudo systemctl status jenkins
#login from console (localhost) first
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
