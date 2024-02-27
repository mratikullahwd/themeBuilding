#!/bin/bash

# Define the domain name
DOMAIN="nexusnodesbd.com"

# Uninstall Nginx
echo "Uninstalling Nginx..."
sudo apt-get remove --purge nginx -y

# Install Apache
echo "Installing Apache..."
sudo apt-get install apache2 -y

# Start Apache service
echo "Starting Apache service..."
sudo systemctl start apache2

# Enable Apache to start on boot
sudo systemctl enable apache2

# Create index.html with pre-made information
echo "Creating index.html for $DOMAIN..."
cat <<EOF | sudo tee /var/www/$DOMAIN/index.html
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

# Create Apache configuration for the domain
echo "Configuring Apache for $DOMAIN..."
sudo mkdir -p /etc/apache2/sites-available
sudo mkdir -p /etc/apache2/sites-enabled

cat <<EOF | sudo tee /etc/apache2/sites-available/$DOMAIN.conf
<VirtualHost *:80>
    ServerAdmin webmaster@$DOMAIN
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot /var/www/$DOMAIN

    ErrorLog \${APACHE_LOG_DIR}/$DOMAIN_error.log
    CustomLog \${APACHE_LOG_DIR}/$DOMAIN_access.log combined
</VirtualHost>
EOF

# Enable the domain site
sudo a2ensite $DOMAIN.conf

# Reload Apache to apply changes
echo "Restarting Apache service..."
sudo systemctl reload apache2

echo "Apache configured for $DOMAIN successfully."
