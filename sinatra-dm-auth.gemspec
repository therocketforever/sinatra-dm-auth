# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-dm-auth}
  s.version = "0.0.1"

  s.authors = ["Dominic Werner"]
  s.date = %q{2009-10-22}
  s.description = %q{sinatra-dm-auth is an extension for Sinatra to add simple user authorization}
  s.email = %q{aka.vince@gmail.com}
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{lib}/**/*")
  s.has_rdoc = true
  s.homepage = %q{http://github.com/daddz/sinatra-dm-auth}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{User authorization extension for Sinatra}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<datamapper>, [">= 0.10.1"])
      s.add_runtime_dependency(%q<rake>, [">= 1.0.1"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
    else
      s.add_dependency(%q<datamapper>, [">= 0.10.1"])
      s.add_dependency(%q<rake>, [">= 1.0.1"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    end
  else
    s.add_dependency(%q<datamapper>, [">= 0.10.1"])
    s.add_dependency(%q<rake>, [">= 1.0.1"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
  end
end
