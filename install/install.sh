#!/bin/bash

# Install Fleet Manager application on Phusion Passenger
# Tested on Debian 8.1

# Create user to run application as
sudo useradd --user-group fm --home-dir /srv/rails/fm --shell /bin/bash --groups sudo

# Create application directory
sudo mkdir -p /srv/rails/fm
sudo chown fm:fm /srv/rails/fm

# Install pre-requisite software
sudo apt-get update
sudo apt-get install -y ruby ruby-dev zlib1g-dev libsqlite3-dev openssl git build-essential

# Generate a self-signed certificate
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/self-signed.pem -keyout /etc/ssl/private/self-signed.key -subj "/C=AU/ST=ACT/L=Canberra/O=Ben Formosa/OU=Fleet Manager/CN=fleetmanager.fm.internal"
sudo chmod 600 /etc/ssl/certs/self-signed.pem
sudo chmod 600 /etc/ssl/private/self-signed.key

# Download init script
sudo wget -q https://raw.githubusercontent.com/benformosa/fm/master/install/initd-fm -O /etc/init.d/fm
sudo chmod +x /etc/init.d/fm

sudo wget -q https://raw.githubusercontent.com/benformosa/fm/master/install/etc-fm -O /etc/fm.sh
sudo chmod +x /etc/fm.sh

# Install required software with gem
sudo gem install passenger --no-ri --no-rdoc
sudo gem install bundler --no-ri --no-rdoc

# Download script to run app install as user fm
wget -q https://raw.githubusercontent.com/benformosa/fm/master/install/fminstall.sh -O ~/fminstall.sh
chmod +x ~/fminstall.sh

sudo ~/fminstall.sh

# Clean up
rm ~/fminstall.sh

# Set setupdb.sh as executable
chmod +x /srv/rails/fm/install/setupdb.sh

# Set secret token
echo "Fm::Application.config.secret_key_base = \"$(cd /srv/rails/fm && bundle exec rake secret)\"" | sudo tee /srv/rails/fm/config/initializers/secret_token.rb > /dev/null

echo
echo $'Edit /srv/rails/fm/config/ldap.yml with your LDAP server details'
echo $'Then run `sudo /srv/rails/fm/install/setupdb.sh` to create database'
echo $'run `sudo /etc/init.d/fm start` to start app'
