# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/nordea/version'

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-nordea'
  gem.version       = Omniauth::Nordea::VERSION
  gem.authors       = ['MAK IT', 'Jānis Kiršteins', 'Kristaps Ērglis']
  gem.email         = ['admin@makit.lv', 'janis@montadigital.com', 'kristaps.erglis@gmail.com' ]
  gem.description   = %q{OmniAuth strategy for Nordea bank}
  gem.summary       = %q{OmniAuth strategy for Nordea bank}
  gem.homepage      = 'https://github.com/mak-it/omniauth-nordea'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'i18n'

  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'
end
