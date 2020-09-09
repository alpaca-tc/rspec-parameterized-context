require_relative 'lib/rspec_parameterized_context/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-parameterized-context"
  spec.version       = RspecParameterizedContext::VERSION
  spec.authors       = ["alpaca-tc", "kamillle"]
  spec.email         = ["alpaca-tc@alpaca.tc", "yuji.kmjm@gmail.com"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/alpaca-tc/rspec-parameterized-context"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
end
