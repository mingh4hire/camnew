#!/bin/bash
# Deploy camera app to Amazon Linux 2023 EC2 instance (IP: 3.135.227.208)

# Build the app locally first
npm run build

# Upload files to EC2 (replace with your EC2 instance details)
EC2_HOST="3.135.227.208"
EC2_USER="ec2-user"
KEY_FILE="your-key.pem"  # Replace with your actual key file path

# Copy built files to nginx html directory
scp -i $KEY_FILE -r dist/* $EC2_USER@$EC2_HOST:/tmp/

# SSH into EC2 and move files
ssh -i $KEY_FILE $EC2_USER@$EC2_HOST << 'EOF'
    sudo mv /tmp/* /usr/share/nginx/html/
    sudo chown -R nginx:nginx /usr/share/nginx/html
    sudo chmod -R 755 /usr/share/nginx/html
    sudo systemctl reload nginx
EOF

echo "Deployment complete! Check https://3.135.227.208"
echo "Note: You'll need to accept the self-signed certificate warning in your browser."