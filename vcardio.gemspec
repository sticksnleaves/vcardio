# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vcardio/version'

Gem::Specification.new do |spec|
  spec.name          = 'vcardio'
  spec.version       = VCardio::VERSION
  spec.authors       = ['Anthony Smith']
  spec.email         = ['anthony@sticksnleaves.com']

  spec.summary       = 'vCard builder and parser for Ruby'
  spec.description   = 'RFC 6350 compliant implementation of vCard for Ruby'
  spec.homepage      = 'https://github.com/sticksnleaves/vcardio.git'
  spec.license       = 'MIT'

  spec.files         = (
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(/^(test|spec|features)\//)
    end
  )

  spec.bindir                = 'exe'
  spec.executables           = spec.files.grep(/^exe\//) { |f| File.basename(f) }
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 1.9.2'

  spec.add_dependency 'manilla', '~> 1.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
