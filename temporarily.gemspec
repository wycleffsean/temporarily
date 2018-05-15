# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'temporarily/version'

Gem::Specification.new do |spec|
  spec.name          = 'temporarily'
  spec.version       = Temporarily::VERSION
  spec.authors       = ['Sean Carey']
  spec.email         = ['wycleffsean@gmail.com']

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,lib}/**/*', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 3.2.22.5'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.56'
  spec.add_development_dependency 'sqlite3'
end
