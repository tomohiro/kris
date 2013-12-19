# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kris/version'

Gem::Specification.new do |spec|
  spec.name          = 'kris'
  spec.version       = Kris::VERSION
  spec.authors       = ['Tomohiro TAIRA']
  spec.email         = ['tomohiro.t@gmail.com']
  spec.description   = 'IRC bot library - Pluggable, and very simple'
  spec.summary       = 'IRC bot library - Pluggable, and very simple'
  spec.homepage      = 'https://github.com/Tomohiro/kris'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'zircon'
  spec.add_runtime_dependency 'activesupport', '~> 4.0.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard-minitest'
end
