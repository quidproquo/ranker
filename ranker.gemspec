$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ranker/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ranker"
  s.version     = Ranker::VERSION
  s.authors     = ['Ilya Scharrenbroich']
  s.email       = ['ilya.j.s@gmail.com']
  s.homepage    = 'https://github.com/quidproquo/ranker'
  s.summary     = 'Library that enables the ranking of lists of items using various ranking strategies.'

  s.files = Dir['{lib}/**/*'] + ['README.md']
  s.require_paths = ['lib']
  s.test_files = Dir['spec/**/*']

  # Development:
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'

end

