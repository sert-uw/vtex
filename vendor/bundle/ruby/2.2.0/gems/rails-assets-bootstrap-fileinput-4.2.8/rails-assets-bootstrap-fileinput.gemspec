# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-bootstrap-fileinput/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-bootstrap-fileinput"
  spec.version       = RailsAssetsBootstrapFileinput::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "An enhanced HTML 5 file input for Bootstrap 3.x with file preview, multiple selection, ajax uploads, and more features."
  spec.summary       = "An enhanced HTML 5 file input for Bootstrap 3.x with file preview, multiple selection, ajax uploads, and more features."
  spec.homepage      = "https://github.com/kartik-v/bootstrap-fileinput"
  spec.license       = "BSD-3-Clause"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-assets-jquery", ">= 1.9.0"
  spec.add_dependency "rails-assets-bootstrap", "~> 3"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
