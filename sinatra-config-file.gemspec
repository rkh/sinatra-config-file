SPEC = Gem::Specification.new do |s|
  # Get the facts.
  s.name             = "sinatra-config-file"
  s.version          = "0.6.1"
  s.description      = "Load Sinatra settings from a yaml file."

  # External dependencies
  s.add_dependency "sinatra", "~> 1.0"
  s.add_development_dependency "rspec", ">= 1.3.0"
  s.add_development_dependency "sinatra-test-helper", "~> 0.5.0"

  s.authors          = ["Konstantin Haase", "Dmitry A. Ustalov"]
  s.email            = "konstantin.mailinglists@googlemail.com"
  s.files            = Dir["**/*.{rb,md}"] << "LICENSE"
  s.has_rdoc         = 'yard'
  s.homepage         = "http://github.com/rkh/#{s.name}"
  s.require_paths    = ["lib"]
  s.summary          = s.description
end
