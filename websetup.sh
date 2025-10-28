#!/bin/bash
# websetup.sh - Install Apache on Ubuntu and deploy a Tooplate template

# 1) Install needed tools and Apache
sudo apt update -y
sudo apt install -y wget unzip apache2

# 2) Start and enable Apache to run on boot
sudo systemctl start apache2
sudo systemctl enable apache2

# 3) Prepare a temp workspace
mkdir -p /tmp/webfiles
cd /tmp/webfiles

# 4) Download and extract the template
wget https://www.tooplate.com/zip-templates/2098_health.zip
unzip -o 2098_health.zip

# 5) Copy template files
#    The extracted folder is '2098_health', not '2098_health.zip'
sudo cp -r 2098_health/* /var/www/html/

# 6) Restart Apache to pick up changes
sudo systemctl restart apache2

# 7) Cleanup
rm -rf /tmp/webfiles

echo "Deployment complete. Open http://<server-ip>/ in your browser."