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

  s.add_dependency "ruby-graphviz"
  s.add_dependency "graphviz"
  # s.add_development_dependency "rspec", "~>2.5"

  s.files         = Dir.glob("{bin,lib}/**/*")
  s.test_files    = Dir.glob("{test,spec,features}/**/*")
  s.executables   = Dir.glob("{bin}/**/*").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
