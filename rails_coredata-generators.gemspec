# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generators/rails_coredata/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_coredata-generators"
  spec.version       = RailsCoredata::Generators::VERSION
  spec.authors       = ["Kazuho Yamaguchi"]
  spec.email         = ["kyamaguchi@mediweb.jp"]
  spec.description   = %q{Rails generators with coredata model}
  spec.summary       = %q{Rails generators with coredata model}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "core_data"
  spec.add_dependency "active_model_serializers"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
