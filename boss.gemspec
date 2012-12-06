$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "boss/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "boss"
  s.version     = Boss::VERSION
  s.authors     = ["Group Buddies"]
  s.email       = ["zamith@groupbuddies.com"]
  s.homepage    = "http://zamith.github.com/Boss"
  s.summary     = "GB CMS"
  s.description = "A CMS that sits on top of Citygate"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["COPYING", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "citygate"
  s.add_dependency "paperclip"
  s.add_dependency "cancan"
  s.add_dependency "acts-as-taggable-on", "~> 2.3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails",      ">= 2.8.1"
  s.add_development_dependency "cucumber-rails",   ">= 1.3.0"
  s.add_development_dependency "capybara",         ">= 1.1.2"
  s.add_development_dependency "database_cleaner", ">= 0.7.1"
  s.add_development_dependency "launchy",          ">= 2.0.5"
  s.add_development_dependency "capybara-webkit"
end
