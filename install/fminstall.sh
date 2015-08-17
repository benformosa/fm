#!/bin/bash
# Clone project from github.com
sudo --login --user=fml --set-home sh -c "git init ."
sudo --login --user=fml --set-home sh -c "git remote remove origin"
sudo --login --user=fml --set-home sh -c "git remote add -t master -f origin https://github.com/benformosa/fml.git"
sudo --login --user=fml --set-home sh -c "git checkout master"

# Set preference to not install rdocs
sudo --login --user=fml --set-home sh -c "echo \"gem: --no-ri --no-rdoc\" > ~/.gemrc"

# Install required software with bundler
sudo --login --user=fml --set-home sh -c "bundle install --deployment"

# Prepare static assets
sudo --login --user=fml --set-home sh -c "RAILS_ENV=production bundle exec rake assets:precompile"