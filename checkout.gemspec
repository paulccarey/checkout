require_relative 'lib/checkout/version'

Gem::Specification.new do |spec|
  spec.name          = "checkout"
  spec.version       = Checkout::VERSION
  spec.authors       = ["Paul Carey"]
  spec.email         = ["paulccarey@gmail.com"]

  spec.summary       = %q{Checkout kata}

  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'monetize', '~> 1.9', '>= 1.9.4'
  spec.add_runtime_dependency 'money', '~> 6.13', '>= 6.13.8'
  spec.add_runtime_dependency 'dry-types', '~> 1.4'
  
end
