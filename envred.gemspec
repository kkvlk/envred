# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envred/version'

Gem::Specification.new do |spec|
  spec.name          = "envred"
  spec.version       = Envred::VERSION
  spec.authors       = ["Kris Kovalik"]
  spec.email         = ["hi@kkvlk.me"]
  spec.description   = %q{This is a tool/wrapper for the apps that set env configuration from given redis machine.}
  spec.summary       = %q{Redis backend env setup proxy.}
  spec.homepage      = "https://github.com/kkvlk/envred"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "redis", "~> 3.0"
  spec.add_dependency "gli", "~> 2.9"
end
