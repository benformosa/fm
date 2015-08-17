#!/bin/bash
# Clone project from github.com
git init .
git remote remove origin
git remote add -t master -f origin https://github.com/benformosa/fml.git
git checkout master

# Set preference to not install rdocs
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# Install required software with bundler
bundle install --deployment

# Prepare static assets
RAILS_ENV=production bundle exec rake assets:precompile
