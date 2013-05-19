# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapquest/version'

Gem::Specification.new do |spec|
  spec.name          = "mapquest"
  spec.version       = MapQuest::VERSION
  spec.authors       = ["Gordan Grasarevic"]
  spec.email         = ["me@ggordan.com"]
  spec.description   = "Retrieve data from various MapQuest web services"
  spec.summary       = "Retrieve data from various MapQuest web services"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "rspec", "~> 2.8"
  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "webmock", "~> 1.11"
  spec.add_development_dependency "rake"
end
