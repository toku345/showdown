# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'md_preview/version'

Gem::Specification.new do |spec|
  spec.name          = "md_preview"
  spec.version       = MdPreview::VERSION
  spec.authors       = ["Fumitaka Tokumitsu"]
  spec.email         = ["toku345@gmail.com"]
  spec.summary       = 'Near-Real time markdown preview'
  spec.description   = 'Near-Real time markdown preview'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'websocket-rack'
  spec.add_runtime_dependency 'redcarpet'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
