# frozen_string_literal: true

require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'fedex_quotes'
  spec.version = '0.0.1'
  spec.licenses = ['MIT']
  spec.summary = 'Get shipping quotes from the FEDEX api'
  spec.authors = ['Gabriel J. Suarez']
  spec.required_ruby_version = '>= 3.2.2'
  spec.files = FileList['lib/**/*.rb',
                        'bin/*',
                        '[A-Z]*'].to_a

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
