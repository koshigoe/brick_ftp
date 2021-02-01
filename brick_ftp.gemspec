lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brick_ftp/version'

Gem::Specification.new do |spec|
  spec.name          = 'brick_ftp'
  spec.version       = BrickFTP::VERSION
  spec.license       = 'MIT'
  spec.authors       = ['koshigoe']
  spec.email         = ['koshigoeb@gmail.com']

  spec.summary       = "BrickFTP's REST API client."
  spec.description   = "BrickFTP's REST API client."
  spec.homepage      = 'https://github.com/koshigoe/brick_ftp'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'codecov', '~> 0.1.10'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.55.0'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'yard', '~> 0.9'

  spec.add_dependency 'deep_hash_transform', '~> 1.0'
  spec.add_dependency 'inifile', '~> 3.0.0'
  spec.add_dependency 'thor', '~> 1.0'
end
