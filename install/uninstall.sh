#!/bin/bash

BACKUPFILE=fml-production-backup_$(date +%s).sqlite3

function uninstall {
  echo "Backup database (Size $(du -h /srv/rails/fml/db/production.sqlite3 | cut -f1)) to $(echo ~/$BACKUPFILE) ?
Select Cancel to exit the uninstaller."
  select yn in "Yes" "No" "Cancel"; do
      case $yn in
	  Yes ) backup; break;;
	  No ) break;;
	  Cancel ) exit;;
      esac
  done
  
  # Stop application
  sudo /etc/init.d/fml stop

  # Remove self-signed certificate
  sudo rm /etc/ssl/certs/self-signed.pem
  sudo rm /etc/ssl/private/self-signed.key

  # Remove init script
  sudo rm /etc/init.d/fml
  sudo rm /etc/fml.sh

  # Remove application directory
  sudo rm -rf /srv/rails/fml

  echo 'You may want to do the following to complete the uninstallation:
`sudo apt-get remove ruby-dev zlib1g-dev libsqlite3-dev openssl git`
`sudo gem uninstall bundler`
`sudo gem uninstall passenger`
`sudo userdel fml`
`sudo groupdel fml`'
}

function backup {
  # Stop application
  sudo /etc/init.d/fml stop
  
  # Make copy of database
  sudo cp /srv/rails/fml/db/production.sqlite3 ~/$BACKUPFILE
  sudo chown `whoami`:`whoami` ~/$BACKUPFILE
  echo "Database backed up to $(echo ~/$BACKUPFILE)"
}

echo "

###########
#         #
# WARNING #
#         #
###########

This script will delete the following files and directories:
/etc/fml.sh
/etc/init.d/fml
/etc/ssl/certs/self-signed.key
/etc/ssl/certs/self-signed.pem
/srv/rails/fml

Are you sure you want to uninstall Fleet Manager?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) uninstall; break;;
        No ) exit;;
    esac
done
