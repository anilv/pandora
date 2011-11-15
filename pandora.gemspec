# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pandora/version"

Gem::Specification.new do |s|
  s.name        = "pandora"
  s.version     = Pandora::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anil"]
  s.homepage    = "http://github.com/anilv/pandora"
  s.summary     = %q{Get Music data from Pandora}
  s.description = %q{A Ruby wrapper for the Pandora public user feeds}
  
  s.add_runtime_dependency 'nokogiri','~> 1.4'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
