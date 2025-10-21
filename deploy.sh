#!/bin/bash
# Deploy script for camera app to nginx server

# Build the app
npm run build

# Create deployment directory on server
ssh user@your-server "sudo mkdir -p /var/www/your-domain.com/html"

# Upload built files
scp -r dist/* user@your-server:/var/www/your-domain.com/html/

# Set proper permissions
ssh user@your-server "sudo chown -R www-data:www-data /var/www/your-domain.com/html"
ssh user@your-server "sudo chmod -R 755 /var/www/your-domain.com/html"

# Reload nginx
ssh user@your-server "sudo systemctl reload nginx"

echo "Deployment complete! Your camera app should now be available at https://your-domain.com"