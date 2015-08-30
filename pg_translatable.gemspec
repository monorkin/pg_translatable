# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pg_translatable/version'

Gem::Specification.new do |spec|
  spec.name = 'pg_translatable'
  spec.version = PgTranslatable::Version::STRING
  spec.authors = ['Stanko Krtalić Rusendić']
  spec.email = ['stanko.krtalic@gmail.com']

  spec.summary = 'Store translations in PG\'s non-sql store types'

  spec.description = 'Store translations in your PG database as HSTORE, JSON '\
                     'or JSONB. This gem handles storage, sanitization, '\
                     'validation and provides scopes to filter your data.'

  spec.homepage = 'https://github.com/Stankec/pg_translatable'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(/^(test|spec|features)\//)
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(/^exe\//) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_dependency 'rails'
  spec.add_dependency 'pg'

  spec.add_development_dependency 'rspec-rails',         '~> 3.2'
  spec.add_development_dependency 'factory_girl_rails',  '~> 4.5'
  spec.add_development_dependency 'pry',                 '~> 0.10'
  spec.add_development_dependency 'pry-rails',           '~> 0.3'
  spec.add_development_dependency 'better_errors',       '~> 2.1'
  spec.add_development_dependency 'binding_of_caller',   '~> 0.7'
  spec.add_development_dependency 'bundler',             '~> 1.8'
  spec.add_development_dependency 'rake',                '~> 10.0'
end
