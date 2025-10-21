#!/bin/bash
# Comprehensive troubleshooting script for nginx on Amazon Linux 2023
# Run this on your EC2 instance

echo "=== Nginx Troubleshooting ==="

# Check if nginx is installed and running
echo "1. Checking nginx status..."
sudo systemctl status nginx --no-pager -l

# Check nginx configuration syntax
echo -e "\n2. Checking nginx configuration..."
sudo nginx -t

# Check if nginx is listening on ports
echo -e "\n3. Checking listening ports..."
sudo netstat -tlnp | grep nginx || sudo ss -tlnp | grep nginx

# Check firewall status
echo -e "\n4. Checking firewall..."
sudo firewall-cmd --list-all

# Check nginx error logs
echo -e "\n5. Recent nginx error logs..."
sudo tail -20 /var/log/nginx/error.log

# Check if files exist in nginx root
echo -e "\n6. Checking deployed files..."
ls -la /usr/share/nginx/html/

# Check nginx access logs
echo -e "\n7. Recent access logs..."
sudo tail -10 /var/log/nginx/access.log

# Test local connection
echo -e "\n8. Testing local HTTP connection..."
curl -I http://localhost

echo -e "\n9. Testing local HTTPS connection..."
curl -k -I https://localhost

echo -e "\n=== Troubleshooting Complete ==="