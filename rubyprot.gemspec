# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubyprot}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bulat"]
  s.date = %q{2009-07-23}
  s.email = %q{mbulat@facesmedia.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rubyprot.rb",
     "lib/rubyprot/serializer.rb",
     "lib/rubyprot/deserializer.rb"     
  ]
  
  s.add_dependency('aws-s3', '>= 0.5.1')
  
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mbulat/rubyprot}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
