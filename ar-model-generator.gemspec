# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ar-model-generator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Changeme"]
  gem.email         = ["stefan.wienert@pludoni.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ar-model-generator"
  gem.require_paths = ["lib"]
  gem.version       = Ar::Model::Generator::VERSION
  gem.add_dependency "activerecord"
  gem.add_dependency "highline"
  gem.add_dependency "mysql2"
  gem.add_dependency "activerecord-mysql2-adapter"
end
