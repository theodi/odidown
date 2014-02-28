# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'odidown/version'

Gem::Specification.new do |s|
  s.name          = "odidown"
  s.version       = OdiDown::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["James Smith"]
  s.email         = ["james.smith@theodi.org"]
  s.homepage      = "http://github.com/theodi/odidown"
  s.summary       = %q{Markdown extensions for the ODI}
  s.license       = "MIT"

  s.files         = Dir[
    'lib/**/*',
    'README.md',
    'Gemfile',
    'Rakefile'
  ]
  s.test_files    = Dir['test/**/*']
  s.require_paths = ["lib"]

  s.add_dependency 'govspeak', '~> 1.2.3'

  s.add_development_dependency 'rake', '~> 0.9.0'
  s.add_development_dependency 'coveralls'
end
