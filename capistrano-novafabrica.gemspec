# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/novafabrica/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-novafabrica"
  spec.version       = Capistrano::NovaFabrica::VERSION
  spec.authors       = ["FotoVerite"]
  spec.email         = ["matt@novafabrica.com"]
  spec.description   = %q{Nova Fabrica Capistrano recipies}
  spec.summary       = %q{Nova Fabrica Capistrano recipies}
  spec.homepage      = "http://github.com/NovaFabrica/capistrano-novafabrica"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
