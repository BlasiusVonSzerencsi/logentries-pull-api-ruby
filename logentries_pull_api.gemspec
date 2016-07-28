# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logentries_pull_api/version'

Gem::Specification.new do |spec|
  spec.name          = "logentries_pull_api"
  spec.version       = LogentriesPullApi::VERSION
  spec.authors       = ["Balazs Szerencsi"]
  spec.email         = ["balazs.szerencsi@icloud.com"]

  spec.summary       = 'LogEntries Pull API.'
  spec.description   = <<-DESCRIPTION
  Ruby wrapper for LogEntries Pull API.
  https://logentries.com/doc/api-download/
  DESCRIPTION
  spec.homepage      = 'https://github.com/BlasiusVonSzerencsi/logentries-pull-api-ruby'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
