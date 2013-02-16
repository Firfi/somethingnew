source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer' #, :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

gem 'rspec-rails', :group => [:test, :development]
gem 'pry-rails', :group => :development
group :test do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'headless'

  gem 'rb-readline'

  gem 'poltergeist', :git => 'git://github.com/jonleighton/poltergeist.git'

end

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'meta_request'
  gem 'annotate', ">=2.5.0"
  gem 'rack-mini-profiler'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem 'backbone-on-rails'
gem 'backbone-syphon-rails'


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
