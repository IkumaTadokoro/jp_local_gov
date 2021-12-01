# -*- encoding: utf-8 -*-
# stub: pdf-reader 2.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pdf-reader".freeze
  s.version = "2.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/yob/pdf-reader/issues", "changelog_uri" => "https://github.com/yob/pdf-reader/blob/v2.6.0/CHANGELOG", "documentation_uri" => "https://www.rubydoc.info/gems/pdf-reader/2.6.0", "source_code_uri" => "https://github.com/yob/pdf-reader/tree/v2.6.0" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Healy".freeze]
  s.date = "2021-11-12"
  s.description = "The PDF::Reader library implements a PDF parser conforming as much as possible to the PDF specification from Adobe".freeze
  s.email = ["james@yob.id.au".freeze]
  s.executables = ["pdf_object".freeze, "pdf_text".freeze, "pdf_callbacks".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "TODO".freeze, "CHANGELOG".freeze, "MIT-LICENSE".freeze]
  s.files = ["CHANGELOG".freeze, "MIT-LICENSE".freeze, "README.md".freeze, "TODO".freeze, "bin/pdf_callbacks".freeze, "bin/pdf_object".freeze, "bin/pdf_text".freeze]
  s.homepage = "https://github.com/yob/pdf-reader".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--title".freeze, "PDF::Reader Documentation".freeze, "--main".freeze, "README.md".freeze, "-q".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A library for accessing the content of PDF files".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["< 13.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5"])
      s.add_development_dependency(%q<cane>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<morecane>.freeze, ["~> 0.2"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<Ascii85>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<ruby-rc4>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<hashery>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<ttfunk>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<afm>.freeze, ["~> 0.2.1"])
    else
      s.add_dependency(%q<rake>.freeze, ["< 13.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
      s.add_dependency(%q<cane>.freeze, ["~> 3.0"])
      s.add_dependency(%q<morecane>.freeze, ["~> 0.2"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_dependency(%q<Ascii85>.freeze, ["~> 1.0"])
      s.add_dependency(%q<ruby-rc4>.freeze, [">= 0"])
      s.add_dependency(%q<hashery>.freeze, ["~> 2.0"])
      s.add_dependency(%q<ttfunk>.freeze, [">= 0"])
      s.add_dependency(%q<afm>.freeze, ["~> 0.2.1"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["< 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
    s.add_dependency(%q<cane>.freeze, ["~> 3.0"])
    s.add_dependency(%q<morecane>.freeze, ["~> 0.2"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_dependency(%q<Ascii85>.freeze, ["~> 1.0"])
    s.add_dependency(%q<ruby-rc4>.freeze, [">= 0"])
    s.add_dependency(%q<hashery>.freeze, ["~> 2.0"])
    s.add_dependency(%q<ttfunk>.freeze, [">= 0"])
    s.add_dependency(%q<afm>.freeze, ["~> 0.2.1"])
  end
end
