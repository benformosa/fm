#!/bin/bash

# Install FML application on Phusion Passenger
# Tested on Debian 8.1

# Create user to run application as
sudo useradd --user-group fml --home-dir /srv/rails/fml --shell /bin/bash --groups sudo

# Create application directory
sudo mkdir -p /srv/rails/fml
sudo chown fml:fml /srv/rails/fml

# Install pre-requisite software
sudo apt-get update
sudo apt-get install -y ruby ruby-dev zlib1g-dev libsqlite3-dev openssl git

# Generate a self-signed certificate
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/self-signed.pem -keyout /etc/ssl/private/self-signed.key -subj "/C=AU/ST=ACT/L=Canberra/O=Ben Formosa/OU=Fleet Manager/CN=fleetmanager.fm.internal"
sudo chmod 600 /etc/ssl/certs/self-signed.pem
sudo chmod 600 /etc/ssl/private/self-signed.key

# Download init script
sudo wget -q https://raw.githubusercontent.com/benformosa/fml/master/install/initd-fml -O /etc/init.d/fml
sudo chmod +x /etc/init.d/fml

sudo wget -q https://raw.githubusercontent.com/benformosa/fml/master/install/etc-fml.sh -O /etc/fml.sh
sudo chmod +x /etc/fml.sh

# Download the database setup script
sudo wget -q https://raw.githubusercontent.com/benformosa/fml/master/install/setupdb.sh -O /srv/rails/fml/setupdb.sh
sudo chown fml:fml /srv/rails/fml/setupdb.sh
sudo chmod +x /srv/rails/fml/setupdb.sh

# Install required software with gem
sudo gem install passenger --no-ri --no-rdoc
sudo gem install bundler --no-ri --no-rdoc

# Download script to run app install as user fml
sudo wget -q https://raw.githubusercontent.com/benformosa/fml/master/install/fminstall.sh -O ~/fminstall.sh
sudo chmod +x ~/fminstall.sh

sudo ~/fminstall.sh

# Clean up
sudo rm ~/fminstall.sh

# Set secret token
echo "Fml::Application.config.secret_key_base = \"$(cd /srv/rails/fml && bundle exec rake secret)\"" | sudo tee /srv/rails/fml/config/initializers/secret_token.rb > /dev/null

echo
echo $'Edit /srv/rails/fml/config/ldap.yml with your LDAP server details'
echo $'Then run `sudo /srv/rails/fml/setupdb.sh` to create database'
echo $'run `sudo /etc/init.d/fml start` to start app'
