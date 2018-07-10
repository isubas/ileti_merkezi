lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ileti_merkezi/version'

Gem::Specification.new do |spec|
  spec.name          = 'ileti_merkezi'
  spec.version       = IletiMerkezi::VERSION
  spec.authors       = ['İrfan SUBAŞ']
  spec.email         = ['irfan.isubas@gmail.com']

  spec.summary       = 'api.iletimerkezi.com API Ruby SMS GEM"'
  spec.description   = '
    api.iletimerkezi.com uzerinden toplu sms gonderme,
    raporlama gibi islemleri yapabilmek icin hazırlanmistir.
  '
  spec.homepage      = 'https://github.com/isubas/ileti_merkezi'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'ox', '~> 2.8', '>= 2.8.2'
end
