# Stash edited config files
sudo --login --user=fm --set-home sh -c "git stash"

# Update project from github.com
sudo --login --user=fm --set-home sh -c "git pull origin master"

# Apply stashed files and delete the stash
sudo --login --user=fm --set-home sh -c "git stash"
sudo --login --user=fm --set-home sh -c "git stash clear"

# Install required software with bundler
sudo --login --user=fm --set-home sh -c "bundle install --deployment"

# Apply database changes
sudo --login --user=fm --set-home sh -c "bundle exec rake db:migrate RAILS_ENV=production"

# Prepare static assets
sudo --login --user=fm --set-home sh -c "RAILS_ENV=production bundle exec rake assets:precompile"
