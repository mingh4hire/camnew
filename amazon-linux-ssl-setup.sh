#!/bin/bash
# Self-signed SSL Certificate setup for Amazon Linux 2023 (IP address)

# Create directory for SSL certificates
sudo mkdir -p /etc/ssl/private
sudo chmod 700 /etc/ssl/private

# Generate self-signed SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=3.135.227.208"

# Set proper permissions
sudo chmod 600 /etc/ssl/private/selfsigned.key
sudo chmod 644 /etc/ssl/certs/selfsigned.crt

echo "Self-signed SSL certificate created successfully!"
echo "Note: Browsers will show a security warning - you need to accept it to proceed."
echo "Your site will be available at https://3.135.227.208"