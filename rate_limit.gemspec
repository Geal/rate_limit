# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rate_limit/version"

Gem::Specification.new do |s|
  s.name        = "rate_limit"
  s.version     = RateLimit::VERSION
  s.authors     = ["Geoffroy Couprie"]
  s.email       = ["geo.couprie@gmail.com"]
  s.homepage    = "https://github.com/Geal/rate_limit"
  s.summary     = %q{rate_limit filters page access in your Rails application}
  s.description = %q{Limit request frequence by IP, by page, for login or password reset forms}

  s.rubyforge_project = "rate_limit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
