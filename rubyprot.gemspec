# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubyprot}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bulat"]
  s.date = %q{2009-07-27}
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
     "lib/rubyprot/deserializer.rb",
     "lib/rubyprot/serializer.rb",
     "rubyprot.gemspec",
     "test/configuration_test.rb",
     "test/deserializer_test.rb",
     "test/serializer_test.rb",
     "test/test_files/models/test_class.rb",
     "test/test_files/models/test_class_two.rb",
     "test/test_files/models/test_module.rb",
     "test/test_files/test_data/deserializer/TestClass",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mbulat/rubyprot}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/configuration_test.rb",
     "test/deserializer_test.rb",
     "test/serializer_test.rb",
     "test/test_files/models/test_class.rb",
     "test/test_files/models/test_class_two.rb",
     "test/test_files/models/test_module.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<aws-s3>, [">= 0.6.1"])
    else
      s.add_dependency(%q<aws-s3>, [">= 0.6.1"])
    end
  else
    s.add_dependency(%q<aws-s3>, [">= 0.6.1"])
  end
end
