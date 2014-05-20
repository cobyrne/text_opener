# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_opener/version'

Gem::Specification.new do |spec|
  spec.name          = "text_opener"
  spec.version       = TextOpener::VERSION
  spec.authors       = ["Colin O'Byrne", "Whitney Schaefer"]
  spec.email         = ["colinobyrne@gmail.com", "whitney.schaefer@gmail.com"]
  spec.description   = %q{Opens SMSs sent via twilio}
  spec.summary       = %q{Opens SMSs sent via twilio to make development easier.}
  spec.homepage      = "http://github.com/cobyrne/text_opener"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "twilio-ruby"
  spec.add_dependency "launchy"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
