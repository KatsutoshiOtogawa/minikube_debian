#! /bin/bash

export DEBIAN_FRONTEND=noninteractive

apt update && apt upgrade -y

apt install -y neovim
apt install -y nmap
apt install -y mlocate
apt install -y tmux

# install docker

apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# add docker group for user priviledge
usermod -aG docker vagrant

# instlal minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
apt install -y ./minikube_latest_amd64.deb
rm ./minikube_latest_amd64.deb

# install kubectl
apt install -y kubernetes-client=1.20.5+really1.20.2-1


su - vagrant -c "minikube start --kubernetes-version v1.20.2 --vm-driver  docker"

updatedb
