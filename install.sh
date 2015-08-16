#!/bin/bash

# Install FML application on Phusion Passenger
# Tested on Debian 8.1

pushd ~

echo "### Install Phusion Passenger"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get -y install apt-transport-https ca-certificates
echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main' | sudo tee --append /etc/apt/sources.list.d/passenger.list > /dev/null
sudo apt-get update
sudo apt-get install -y passenger

echo "### Create self-signed certificate"
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/self-signed.pem -keyout /etc/ssl/private/self-signed.key
sudo chmod 600 /etc/ssl/certs/self-signed.pem
sudo chmod 600 /etc/ssl/private/self-signed.key

echo "### Create initscript"
sudo useradd --shell /bin/false --system --user-group -M passenger
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
APPPATH="/var/apps/$APP"
PIDFILE="/var/run/$APP.pid"
LOGFILE="/var/log/$APP.log"
PORT=443
SSL_CERT=/etc/ssl/certs/self-signed.pem
SSL_KEY=/etc/ssl/private/self-signed.key
USER=passenger

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

echo "### Install Rails"
sudo apt-get install -y ruby ruby-dev zlib1g-dev libsqlite3-dev
sudo gem install rails --no-ri --no-rdoc
sudo gem install rake --no-ri --no-rdoc

echo "### Install app"
sudo apt-get install -y git
git clone https://github.com/benformosa/fml.git
sudo mkdir /var/apps
sudo ln -s ~/fml /var/apps
cd fml
bundle install --deployment
echo "Fml::Application.config.secret_key_base = '$(bundle exec rake secret)'" | tee --append config/initializers/secret_token.rb > /dev/null

echo
echo $'Edit ~/fml/config/ldap.yml with your LDAP server details'
echo $'Then run `bundle exec rake db:setup` to create database'
echo $'run `/etc/init.d/fml start` to start app'

popd
