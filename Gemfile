source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1'
gem 'rails-i18n', '~> 6.0.0'
gem 'webpacker', '~>5.0'
gem 'turbo-rails'
gem 'attr_json'
gem 'aws-sdk-s3', '~> 1'
gem 'jbuilder', '~> 2.7'
gem 'jwt'
gem 'kaminari'
gem 'money-rails', '~>1.12'
gem 'net-ssh'
gem 'responders'
gem 'sambal'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'stimulus-rails'
gem 'store_base_sti_class'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'
# Use Active Model has_secure_password
gem 'active_data'
gem 'authentication-zero', '~> 2.16'

gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'htmlbeautifier'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'solargraph'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'graphiti'
gem 'graphiti-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'vandal_ui'
group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 5.0'
  gem 'faker', '~> 2.5'
  gem 'graphiti_spec_helpers'
  gem 'rspec-rails', '~> 4.0.0beta2'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
end

gem 'polaris_view_components', '~> 1.0'
