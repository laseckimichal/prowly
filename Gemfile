source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6.1.0'
gem 'sqlite3', '~> 1.4'

gem 'puma', '< 6'

gem 'activerecord-import'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'globalid', '~> 1.0'
gem 'nokogiri'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :development do
  gem 'factory_bot_rails'
  gem 'faker', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
