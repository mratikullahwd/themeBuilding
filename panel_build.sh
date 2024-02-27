#!/bin/bash

# Define the domain name
DOMAIN="nexusnodesbd.com"

# Uninstall Nginx
echo "Uninstalling Nginx..."
sudo apt-get remove --purge nginx -y > /dev/null 2>&1
sudo apt-get autoremove
echo "50% completed."

# Install Apache
echo "Installing Apache..."
sudo apt update
sudo apt install apache2
sudo ufw app list
sudo ufw allow 'Apache'
sudo systemctl status apache2
echo "60% completed."

# Start Apache service
echo "Starting Apache service..."
sudo systemctl start apache2 > /dev/null 2>&1
echo "70% completed."

# Enable Apache to start on boot
echo "Enabling Apache..."
sudo systemctl enable apache2 > /dev/null 2>&1
echo "80% completed."

# Setting Site
echo "Creating Site..."
sudo mkdir /var/www/$DOMAIN
sudo chown -R $USER:$USER /var/www/$DOMAIN
sudo chmod -R 755 /var/www/$DOMAIN
sudo mkdir /var/www/$DOMAIN
cat <<EOF | sudo tee /var/www/$DOMAIN/index.html > /dev/null
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to $DOMAIN</title>
</head>
<body>
  <h1>Welcome to $DOMAIN</h1>
  <p>This is a pre-made website with some information.</p>
  <p>You can replace this content with your own.</p>
</body>
</html>
EOF
echo "90% completed."

sudo mkdir /etc/apache2/sites-available
cat <<EOF | sudo tee /etc/apache2/sites-available/$DOMAIN.conf > /dev/null
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot /var/www/$DOMAIN
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
echo "Site Created..."
echo "95% completed."


sudo a2ensite $DOMAIN.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
echo "100% completed."

echo "Apache configured for $DOMAIN successfully."

