SPEC = Gem::Specification.new do |s|

  # Get the facts.
  s.name             = "sinatra-config-file"
  s.version          = "0.5.0"
  s.description      = "Load Sinatra settings from a yaml file (part of BigBand)."

  # External dependencies
  s.add_dependency "sinatra", "~> 1.0"
  s.add_development_dependency "rspec", ">= 1.3.0"
  s.add_development_dependency "sinatra-test-helper", "~> 0.5.0"

  # Those should be about the same in any BigBand extension.
  # But not, 'cos BigBand sucks.
  s.authors          = ["Konstantin Haase", 'Dmitry A. Ustalov']
  s.email            = "dmitry@eveel.ru"
  s.files            = Dir["**/*.{rb,md}"] << "LICENSE"
  s.has_rdoc         = 'yard'
  s.homepage         = "http://github.com/eveel/#{s.name}"
  s.require_paths    = ["lib"]
  s.summary          = s.description
  
end
