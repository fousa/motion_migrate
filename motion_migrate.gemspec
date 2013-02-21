# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name          = "motion_migrate"
  gem.version       = MotionMigrate::VERSION
  gem.authors       = ["Jelle Vandebeeck"]
  gem.email         = ["jelle@fousa.be"]
  gem.description   = %q{Generate the Core Data model from your RubyMotion code.}
  gem.summary       = %q{Generate the Core Data model from your RubyMotion code. Never open XCode again!}
  gem.homepage      = "http://fousa.github.com/motion_migrate/"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_dependency 'nokogiri'
end
