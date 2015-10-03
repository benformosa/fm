#!/bin/bash
sudo --login --user=fm --set-home sh -c "bundle exec rake db:setup RAILS_ENV=production"
