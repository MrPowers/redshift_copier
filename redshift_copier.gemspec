# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redshift_copier/version'

Gem::Specification.new do |spec|
  spec.name          = "redshift_copier"
  spec.version       = RedshiftCopier::VERSION
  spec.authors       = ["MrPowers"]
  spec.email         = ["matthewkevinpowers@gmail.com"]

  spec.summary       = %q{Using the Redshift COPY command}
  spec.description   = %q{Using the Redshift COPY command to load a single file or a collection of files specified in a manifest file}
  spec.homepage      = "https://github.com/MrPowers/redshift_copier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
