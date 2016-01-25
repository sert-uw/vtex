# -*- encoding: utf-8 -*-
# stub: bootstrap-filestyle-rails 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-filestyle-rails"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mauricio Pasquier Juan"]
  s.date = "2014-10-01"
  s.description = "Bootstrap Filestyle (gem version reflects assets\n                          version) packaged for rails"
  s.email = ["mauricio@pasquierjuan.com.ar"]
  s.homepage = "https://github.com/mauriciopasquier/bootstrap-filestyle-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Bootstrap Filestyle for the asset pipeline"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
