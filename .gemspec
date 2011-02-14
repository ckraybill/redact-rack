Gem::Specification.new do |s|
  s.name        = "redact-rack"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Nutt"]
  s.email       = "michael@nuttnet.net"
  s.homepage    = "https://github.com/mnutt/redact-rack"
  s.summary     = "Automatically redact words on your website"
  s.description = "Specify words to redact in a config/redacted.yml file and watch them automatically disapper from your markup"

  s.add_development_dependency "rspec"

  s.files        = Dir.glob("lib/**/*") + %w(README)
  s.require_path = 'lib'
end
