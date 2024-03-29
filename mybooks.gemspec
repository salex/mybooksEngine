require_relative "lib/mybooks/version"

Gem::Specification.new do |spec|
  spec.name        = "mybooks"
  spec.version     = Mybooks::VERSION
  spec.authors     = ["Steve Alex"]
  spec.email       = ["salex@mac.com"]
  spec.homepage    = "http://stevealex.us"
  spec.summary     = "Summary of Mybooks."
  spec.description = "Description of Mybooks."
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://stevealex.us/repo"
  spec.metadata["changelog_uri"] = "http://stevealex.us/md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "slim"
  spec.add_dependency "slim-rails"
end
