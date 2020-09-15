# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ileti_merkezi/version'

Gem::Specification.new do |spec|
  spec.name          = 'ileti_merkezi'
  spec.version       = IletiMerkezi::VERSION
  spec.authors       = ['isubas']
  spec.email         = ['irfan.isubas@gmail.com']

  spec.summary       = 'Client for api.iletimerkezi.com'
  spec.description   = '
    api.iletimerkezi.com via bulk sms sending, reporting has been prepared to do operations such as.
  '
  spec.homepage      = 'https://github.com/isubas/ileti_merkezi'
  spec.license       = 'MIT'

  spec.files = Dir['lib/**/*', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'rake', '~> 13.0'

  spec.add_dependency 'ox', '~> 2.10'
end
