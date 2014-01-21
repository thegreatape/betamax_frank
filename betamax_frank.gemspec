# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'betamax_frank/version'

Gem::Specification.new do |spec|
  spec.name          = "betamax_frank"
  spec.version       = BetamaxFrank::VERSION
  spec.authors       = ["Thomas Mayfield"]
  spec.email         = ["Thomas.Mayfield@gmail.com"]
  spec.summary       = %q{Client library for integrating the betamax HTTP recording server with Frank for automated iOS testing.}
  spec.homepage      = ""
  spec.license       = "MIT"

  files = `git ls-files`.split($/)
  spec.files         = files.reject {|f| File.basename(f) == 'betamax'}
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "faraday", "~> 0.9"
end
