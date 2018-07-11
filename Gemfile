source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

group :development, :test do
  gem 'dotenv'
  gem 'pry'
  gem 'rubocop'
end

group :test do
  gem 'codacy-coverage', require: false
  gem 'minitest-focus'
  gem 'minitest-reporters'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
