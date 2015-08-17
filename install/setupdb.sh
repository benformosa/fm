#!/bin/bash
sudo --login --user=fml --set-home sh -c "bundle exec rake db:setup RAILS_ENV=production"
