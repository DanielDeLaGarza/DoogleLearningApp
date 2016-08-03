source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'heroku_san'
gem 'nokogiri'
gem 'faraday'
#gem 'rails_admin'
gem 'webmock'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'awesome_print'

group :development, :test do
  gem 'chromedriver-helper', '1.0.0'
  gem 'mysql2', '>= 0.3.18', '< 0.5'
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'jasmine'
  gem 'guard-rspec'
  gem 'faker'
  gem 'launchy'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
