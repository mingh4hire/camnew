#!/bin/bash
# Install nginx on Amazon Linux 2023
sudo dnf update -y
sudo dnf install -y nginx

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Certbot for SSL certificates
sudo dnf install -y certbot python3-certbot-nginx

# Open firewall ports (if using firewalld)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo "Nginx installed and firewall configured"