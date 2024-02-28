#!/bin/bash

# Define the domain name
DOMAIN="panel.gamehostpro.com"

# Uninstall Nginx
echo "Removing Panel Files"
sudo rm -r /var/www/pterodactyl

echo "Uninstalling Nginx..."
sudo apt-get remove --purge nginx -y > /dev/null 2>&1
sudo apt-get autoremove
echo "50% completed."

# Install Apache
echo "Installing Apache..."
sudo apt update
sudo apt install apache2 -y
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
sudo cd /var/www/$DOMAIN
sudo apt install wget -y

cd /var/www/$DOMAIN && sudo wget https://github.com/mratikullahwd/themeBuilding/raw/main/hehe.mp4 && cd

cat <<EOF | sudo tee /var/www/$DOMAIN/index.html > /dev/null
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Background Video with Sound</title>
<style>
  body, html {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow: hidden;
  }
  #video-background {
    position: fixed;
    right: 0;
    bottom: 0;
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    z-index: -1000;
    overflow: hidden;
  }
  #text-overlay {
    position: absolute;
    top: 20px;
    left: 20px;
    color: white;
    font-size: 24px;
    font-family: Arial, sans-serif;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  }
</style>
</head>
<body>

    <video autoplay muted loop id="bgVideo">
      <source src="https://panel.gamehostpro.com/hehe.mp4" type="video/mp4">
      Your browser does not support HTML5 video.
    </video>

<div id="text-overlay">
  Welcome to our website!
</div>

 

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
