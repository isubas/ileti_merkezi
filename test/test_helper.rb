require 'simplecov'
require 'codacy-coverage' if ENV['CI']

SimpleCov.start 'rails' do
  add_filter '/app/channels'
end

Codacy::Reporter.start if ENV['CI']

SimpleCov.start do
  add_filter '/test/'
end

require 'ileti_merkezi'
require 'dotenv/load'
require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/reporters'
require 'vcr'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

TEST_PHONE = ENV.fetch('TEST_PHONE', '0555 444 33 22')

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.before_record do |i|
    i.response.body.force_encoding('utf-8')
  end
  config.filter_sensitive_data('USERNAME') { ENV['IM_USERNAME'] }
  config.filter_sensitive_data('PASSWORD') { ENV['IM_PASSWORD'] }
  config.filter_sensitive_data('PUBLIC_KEY') { ENV['IM_PUBLIC_KEY'] }
  if IletiMerkezi.configuration.auth_method == :auth_token
    config.filter_sensitive_data('HASH') { IletiMerkezi.configuration.hmac }
  end
  config.filter_sensitive_data('PHONE') { TEST_PHONE }
  config.allow_http_connections_when_no_cassette = false
  config.ignore_hosts 'api.codacy.com'
end
