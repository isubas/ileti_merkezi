# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

group :development, :test do
  gem 'dotenv'
  gem 'pry'
  gem 'rubocop'
end

group :test do
  gem 'codacy-coverage', '>= 2.1.0', require: false
  gem 'minitest-focus'
  gem 'minitest-reporters'
  gem 'simplecov', '>= 0.16.1', require: false
  gem 'vcr'
  gem 'webmock'
end
