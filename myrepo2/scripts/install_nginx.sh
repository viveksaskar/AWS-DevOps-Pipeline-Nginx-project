#!/bin/bash

# sudo apt-get update for ubuntu
# sudo apt-get install -y nginx
chmod +x scripts/install_nginx.sh

# Update the package list
sudo dnf update -y

# Install NGINX
sudo dnf install nginx -y

