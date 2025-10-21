#!/bin/bash
# Deploy camera app to Amazon Linux 2023 EC2 instance

# Build the app locally first
npm run build

# Upload files to EC2 (replace with your EC2 instance details)
EC2_HOST="your-ec2-instance-ip"
EC2_USER="ec2-user"

# Copy built files to nginx html directory
scp -i your-key.pem -r dist/* $EC2_USER@$EC2_HOST:/tmp/

# SSH into EC2 and move files
ssh -i your-key.pem $EC2_USER@$EC2_HOST << 'EOF'
    sudo mv /tmp/* /usr/share/nginx/html/
    sudo chown -R nginx:nginx /usr/share/nginx/html
    sudo chmod -R 755 /usr/share/nginx/html
    sudo systemctl reload nginx
EOF

echo "Deployment complete! Check https://your-domain.com"