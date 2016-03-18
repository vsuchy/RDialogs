# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdialogs/version'

Gem::Specification.new do |spec|
  spec.name    = 'rdialogs'
  spec.version = RDialogs::VERSION
  spec.authors = ['Vladimir Suchy']
  spec.email   = ['vs.git@vsuchy.com']

  spec.summary     = 'TODO.'
  spec.description = 'TODO.'
  spec.homepage    = 'https://github.com/vsuchy/RDialogs'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(features|spec|test)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',  '~> 1.11'
  spec.add_development_dependency 'rake',     '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
