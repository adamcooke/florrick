require File.expand_path('../lib/florrick/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "florrick"
  s.description   = %q{A Rails extension for providing awesome user-initiated string interpolation}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/florrick"
  s.version       = Florrick::VERSION
  s.files         = Dir.glob("{lib}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
end
