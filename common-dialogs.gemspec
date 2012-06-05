$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "common-dialogs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "common-dialogs"
  s.version     = CommonDialogs::VERSION
  s.authors     = ["Rodrigo Rosenfeld Rosas"]
  s.email       = ["rr.rosas@gmail.com"]
  s.homepage    = "http://github.com/rosenfeld/common-dialogs"
  s.summary     = "Common JavaScript dialogs"
  s.description = "Provide non-blocking (asynchronous) alert, confirm and prompt for JavaScript applications"

  s.files       = Dir["{app,config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "jquery-rails"
  s.add_dependency "coffee-rails"
end
