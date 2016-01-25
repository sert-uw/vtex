# -*- encoding: utf-8 -*-
# stub: rails-assets-bootstrap-fileinput 4.2.8 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-bootstrap-fileinput"
  s.version = "4.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rails-assets.org"]
  s.date = "2015-11-29"
  s.description = "An enhanced HTML 5 file input for Bootstrap 3.x with file preview, multiple selection, ajax uploads, and more features."
  s.homepage = "https://github.com/kartik-v/bootstrap-fileinput"
  s.licenses = ["BSD-3-Clause"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "An enhanced HTML 5 file input for Bootstrap 3.x with file preview, multiple selection, ajax uploads, and more features."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails-assets-jquery>, [">= 1.9.0"])
      s.add_runtime_dependency(%q<rails-assets-bootstrap>, ["~> 3"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails-assets-jquery>, [">= 1.9.0"])
      s.add_dependency(%q<rails-assets-bootstrap>, ["~> 3"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails-assets-jquery>, [">= 1.9.0"])
    s.add_dependency(%q<rails-assets-bootstrap>, ["~> 3"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
