# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vvv/version"

Gem::Specification.new do |s|
  s.name        = "vvv"
  s.version     = Vvv::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rodrigo Souza"]
  s.email       = ["rodrigorgs@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Allow R projects with variable scripts.}
  s.description = %q{...}

  s.add_runtime_dependency "launchy"
  s.add_development_dependency "rspec", "~>2.5.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end