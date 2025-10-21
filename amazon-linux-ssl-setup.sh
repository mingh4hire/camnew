#!/bin/bash
# SSL Certificate setup for Amazon Linux 2023

# Install Certbot
sudo dnf install -y certbot python3-certbot-nginx

# Get SSL certificate (replace your-domain.com with your actual domain)
# Make sure your domain DNS points to your EC2 instance first
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Test certificate renewal
sudo certbot renew --dry-run

# Set up automatic renewal (runs twice daily)
echo "0 12,0 * * * root /usr/bin/certbot renew --quiet" | sudo tee -a /etc/crontab

echo "SSL certificate installed successfully!"
echo "Your site should now be available at https://your-domain.com"