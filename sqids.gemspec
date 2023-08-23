# frozen_string_literal: true

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqids'

Gem::Specification.new do |gem|
  gem.name          = 'sqids'
  gem.version       = '0.1.1'
  gem.authors       = ['Sqids Maintainers']
  gem.summary       = 'Generate YouTube-like ids from numbers.'
  gem.homepage      = 'https://sqids.org/ruby'
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 3.0'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']
  gem.metadata['rubygems_mfa_required'] = 'true'
end
