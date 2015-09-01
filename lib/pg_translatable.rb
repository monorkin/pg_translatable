require 'pg_translatable/version'
require 'pg_translatable/translatable'

module PgTranslatable
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend(PgTranslatable::Translatable)
end
