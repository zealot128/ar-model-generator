# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Stefan Wienert"]
  gem.email         = ["stefan.wienert@pludoni.de"]
  gem.description   = %q{Useful to generate namespaced database models for a legacy database}
  gem.summary       = %q{We used this, to generate the basic scaffold of our 50+ tables legacy database. This gem subclasses each of the models in a given namespace which inherits from a namespace::Base class. }
  gem.homepage      = "https://github.com/zealot128/ar-model-generator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ar-model-generator"
  gem.require_paths = ["lib"]
  gem.version       = "0.3"
  gem.add_dependency "activerecord"
  gem.add_dependency "highline"
  gem.add_dependency "mysql2"
  gem.add_dependency "activerecord-mysql2-adapter"
  gem.add_development_dependency "rake"
end
