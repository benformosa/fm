#!/bin/bash

# Install FML application on Phusion Passenger
# Tested on Debian 8.1

# Create user to run application as
sudo useradd --user-group fml --home-dir /srv/rails/fml --shell /bin/bash --groups sudo
echo 'Set password for user fml'
sudo passwd fml

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

# Create an init script
echo '#!/bin/bash
### BEGIN INIT INFO
# Provides:          fml
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: FML Rails web app
# Description:       Enable FML service using Phusion Passenger.
#       Shamelessly cadged from https://gist.github.com/naholyr/4275302
### END INIT INFO

APP=fml
APPPATH="/srv/rails/$APP"
PIDFILE="/var/run/$APP.pid"
LOGFILE="/var/log/$APP.log"
PORT=443
SSL_CERT=/etc/ssl/certs/self-signed.pem
SSL_KEY=/etc/ssl/private/self-signed.key
USER=fml

SCRIPT="cd $APPPATH; passenger start -p $PORT --environment production --ssl --ssl-certificate $SSL_CERT --ssl-certificate-key $SSL_KEY --daemonize --user $USER --log-file $LOGFILE --pid-file $PIDFILE"

start() {
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
    echo "Service already running" >&2
    return 1
  fi
  echo "Starting service…" >&2
  su -c "$SCRIPT"
  echo "Service started" >&2
}

stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo "Service not running" >&2
    return 1
  fi
  echo "Stopping service…" >&2
  passenger stop --pid-file $PIDFILE && rm -f "$PIDFILE"
  echo "Service stopped" >&2
}

status() {
  passenger status --pid-file $PIDFILE
}

if [[ $EUID -ne 0 ]]; then
  echo "You must be root" 2>&1
  exit 1
else
  case "$1" in
    status)
      status
      ;;
    start)
      start
      ;;
    stop)
      stop
      ;;
    restart)
      stop
      start
      ;;
    *)
      echo "Usage: $0 {status|start|stop|restart}"
  esac
fi' | sudo tee /etc/init.d/fml > /dev/null
sudo chmod +x /etc/init.d/fml

# Install required software with gem
sudo gem install passenger --no-ri --no-rdoc
sudo gem install bundler --no-ri --no-rdoc

# Create the database setup script
echo '#!/bin/bash
sudo --login --user=fml --set-home sh -c "bundle exec rake db:setup RAILS_ENV=production"' | sudo tee /srv/rails/fml/setupdb.sh > /dev/null
sudo chown fml:fml /srv/rails/fml/setupdb.sh
sudo chmod +x /srv/rails/fml/setupdb.sh

# Create a script to run app install as user fml
echo '# Clone project from github.com
sudo --login --user=fml --set-home sh -c "git init ."
sudo --login --user=fml --set-home sh -c "git remote remove origin"
sudo --login --user=fml --set-home sh -c "git remote add -t master -f origin https://github.com/benformosa/fml.git"
sudo --login --user=fml --set-home sh -c "git checkout master"
# Set preference to not install rdocs
sudo --login --user=fml --set-home sh -c "echo \"gem: --no-ri --no-rdoc\" > ~/.gemrc"
# Install required software with bundler
sudo --login --user=fml --set-home sh -c "bundle install --deployment"
# Prepare static assets
sudo --login --user=fml --set-home sh -c "RAILS_ENV=production bundle exec rake assets:precompile"' | sudo tee /srv/rails/fml/fmlinstall.sh > /dev/null
sudo chown fml:fml /srv/rails/fml/fmlinstall.sh
sudo chmod +x /srv/rails/fml/fmlinstall.sh

sudo /srv/rails/fml/fmlinstall.sh

# Set secret token
echo "Fml::Application.config.secret_key_base = \"$(cd /srv/rails/fml && bundle exec rake secret)\"" | sudo tee /srv/rails/fml/config/initializers/secret_token.rb > /dev/null

echo
echo $'Edit /srv/rails/fml/config/ldap.yml with your LDAP server details'
echo $'Then run `sudo /srv/rails/fml/setupdb.sh` to create database'
echo $'run `sudo /etc/init.d/fml start` to start app'
