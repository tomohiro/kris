# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kris/version'

Gem::Specification.new do |gem|
  gem.name          = 'kris'
  gem.version       = Kris::VERSION
  gem.authors       = ['Tomohiro TAIRA']
  gem.email         = ['tomohiro.t@gmail.com']
  gem.description   = 'IRC bot library - Pluggable, and very simple'
  gem.summary       = 'IRC bot library - Pluggable, and very simple'
  gem.homepage      = 'https://github.com/Tomohiro/kris'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'zircon'
end
