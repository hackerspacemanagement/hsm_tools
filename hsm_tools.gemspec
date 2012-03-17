$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hsm_tools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hsm_tools"
  s.version     = HsmTools::VERSION
  s.authors     = ["Ryan Rix"]
  s.email       = ["ry@n.rix.si"]
  s.homepage    = "https://github.com/hackerspacemanagement"
  s.summary     = "This plugin adds tool management to Hackerspace Management"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
