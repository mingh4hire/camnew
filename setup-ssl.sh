#!/bin/bash
# Install Certbot for automatic SSL certificates
# Run this on your server

# Install Certbot and nginx plugin
sudo apt update
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate (replace your-domain.com with your actual domain)
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Test certificate renewal
sudo certbot renew --dry-run

# The above command will automatically modify your nginx config
# to include SSL settings