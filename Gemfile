source 'https://rubygems.org'

gem 'rails', '4.0.3'
gem 'rake', '10.4.2'
gem 'sqlite3'
gem 'dossier'

# Using my fork to summarise duplicate results
gem 'rails4-autocomplete', :git => 'https://github.com/benformosa/rails4-autocomplete'

gem "rails-settings-cached"

# Use devise for authentication
gem 'devise', '~> 3.4.1'
gem 'devise_ldap_authenticatable', :git => 'https://github.com/cschiewek/devise_ldap_authenticatable'

# Use pundit for authorisation
gem 'pundit'

gem 'bootstrap-datepicker-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'capybara'
  gem 'launchy'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem 'guard'
  gem 'guard-rspec', '~> 4.2.7'
  gem 'rename'
  # for rails.vim
  gem 'erubis', '~> 2.7.0'
  gem 'parallel_tests'
end
