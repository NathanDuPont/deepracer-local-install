#!/bin/bash
echo "Installing DeepRacer Offline for Linux..."

# Update System
sudo apt-get update
sudo apt-get -y upgrade

# Add Directory for DeepRacer Components
[ ! -d "~/deepracer" ] && sudo mkdir ~/deepracer
cd ~/deepracer

# Install Components
sudo apt-get -y install \
    git \
    python3 \
    python3-pip \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

    pip3 install --upgrade pip
    pip3 install --upgrade setuptools

# Configure Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

sudo apt-get update 
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Install and Configure Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Clone Git Repository
[ ! -d "./deepracer-local" ] && sudo git clone https://github.com/NathanDuPont/deepracer-local.git